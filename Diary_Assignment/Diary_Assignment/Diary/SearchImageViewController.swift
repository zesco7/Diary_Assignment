//
//  SearchImageViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/29.
//

import UIKit

/*서치바+컬렉션뷰 순서
 1.뷰컨트롤러에 서치바+컬렉션뷰 있는 메인뷰 로드하기
 2.메인뷰 통해 컬렉션뷰에 프로토콜 연결
 3.커스텀뷰로 컬렉션뷰셀 만들어서 재사용셀로 사용
 */
class SearchImageViewController: BaseViewController {
    
    var mainView = SearchImageView()
    override func loadView() {
        self.view = mainView
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(SearchImageCollectionViewCell.self, forCellWithReuseIdentifier: "SearchImageCollectionViewCell")
        
        mainView.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: nil, action: nil)
    }

}

extension SearchImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchImageCollectionViewCell", for: indexPath) as? SearchImageCollectionViewCell else { return UICollectionViewCell() }
        cell.photoImageView.backgroundColor = .orange
        cell.photoImageView.tag = indexPath.item
        //print(cell.photoImageView.tag)
        return cell
    }
    
    //셀선택시 박스표시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SearchImageCollectionViewCell {
            cell.showSelectionBox()
        }
    }
    
    //셀선택시 박스제거
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SearchImageCollectionViewCell {
            cell.hideSelectionBox()
        }
    }
}
