//
//  SearchImageViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/29.
//

import UIKit

import Kingfisher

/*서치바+컬렉션뷰 순서
 1.뷰컨트롤러에 서치바+컬렉션뷰 있는 메인뷰 로드하기
 2.메인뷰 통해 컬렉션뷰에 프로토콜 연결
 3.커스텀뷰로 컬렉션뷰셀 만들어서 재사용셀로 사용
 4.네트워크통신으로 데이터 잘 들어오는지 확인(클로저로 받은 데이터배열을 빈배열에 넣어서 이미지데이터 요청 때 사용: 전체검색수, 이미지주소)
 5.시작페이지 갱신할 수 있도록 페이지네이션 적용
 6.서치바 프로토콜, 메서드 등록: 검색버튼 클릭액션(클릭시 서치바값을 검색어로 사용), 취소버튼 생성, 취소버튼 클릭액션(클릭시 데이터리셋)
 */


/*질문
 -.searchBarSearchButtonClicked에서 imageArray.removeAll() 없어도 되지 않나? fetchImage 호출할때 imageArray에 데이터 덮어씌워지니까
 
 */
class SearchImageViewController: BaseViewController {
    
    var mainView = SearchImageView()
    var imageArray : [String] = []
    var startPage = 0
    var totalCount = 0
    
    override func loadView() {
        self.view = mainView
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(SearchImageCollectionViewCell.self, forCellWithReuseIdentifier: "SearchImageCollectionViewCell")
        mainView.searchBar.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: nil, action: #selector(saveRightBarButtonItemClicked))
        
    }
    
    @objc func saveRightBarButtonItemClicked() {
        NotificationCenter.default.post(name: .saveButton, object: nil, userInfo: ["name": mainView.searchBar.text!, "value": 123456])
    }
    
    func fetchImage(query: String) {
        ImageSearchAPIManager.shared.fetchImageData(query: query) { totalCount, link in
            self.totalCount = totalCount
            self.imageArray = link
            self.mainView.collectionView.reloadData()
            print(self.imageArray)
        }
    }
}

extension SearchImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchImageCollectionViewCell", for: indexPath) as? SearchImageCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: imageArray[indexPath.item])
        cell.photoImageView.kf.setImage(with: url)
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

//페이지네이션
extension SearchImageViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths { //이미지반복문제 처리(시작페이지 갱신)
            if imageArray.count - 1 == indexPath.count && imageArray.count < totalCount {
                startPage += 50
                fetchImage(query: mainView.searchBar.text!)
            }
            print("=======\(indexPaths)======")
        }
    }
}

extension SearchImageViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            //imageArray.removeAll() //fetchImage 호출할때 imageArray에 데이터 덮어씌워지니까 삭제 안해도 되지 않나?
            fetchImage(query: text)
        }
    }
    
    //취소버튼 생성
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    //취소버튼 클릭액션
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        imageArray.removeAll()
        mainView.collectionView.reloadData() //데이터 지우고 리로드
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
