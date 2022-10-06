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
 -. selectionRightBarButtonItemClicked에서 사진선택해야만 선택버튼 작동하도록 조건 어떻게?
 -. cellForItemAt에서 설정한 태그를 외부에서 어떻게 접근하는지? selectionRightBarButtonItemClicked에서 imageArray 배열값에 태그를 넣을 때 사용하려고함.
 */
class SearchImageViewController: BaseViewController {
    
    var mainView = SearchImageView()
    var imageArray : [String] = []
    var startPage = 0
    var totalCount = 0
    var selectedImageIndex : Int?
    var selettedImage : UIImage?
    
    override func loadView() {
        self.view = mainView
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(SearchImageCollectionViewCell.self, forCellWithReuseIdentifier: "SearchImageCollectionViewCell")
        mainView.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let details = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(detailsRightBarButtonItemClicked))
        let selection = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectionRightBarButtonItemClicked))
        
        navigationItem.rightBarButtonItems = [details, selection]
    }
    
    @objc func detailsRightBarButtonItemClicked() {
        
        if #available(iOS 14.0, *) {
            self.showUIMenu()
            print("iOS14.0~", #function)
        } else {
            self.showActionSheet()
            print("iOS~13.9", #function)
        }
    }
    
    @objc func selectionRightBarButtonItemClicked() {
        print(#function)
        let vccell = SearchImageCollectionViewCell()
        
        //        NotificationCenter.default.post(name: NSNotification.Name("savedImage"), object: nil, userInfo: ["savedImage": vc.photoImage.image) //타입캐스팅 어떻게?
        if let isNotNil = selectedImageIndex {
            NotificationCenter.default.post(name: NSNotification.Name("savedImageURL"), object: nil, userInfo: ["savedImageURL": imageArray[selectedImageIndex!]])
                self.navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "선택한 사진이 없습니다", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
    
    func fetchImage(query: String) {
        ImageSearchAPIManager.shared.fetchImageData(query: query) { totalCount, link in
            self.totalCount = totalCount
            self.imageArray = link
            self.mainView.collectionView.reloadData()
            print(self.imageArray)
        }
    }
    
    func showUIMenu() {
        let details = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(detailsRightBarButtonItemClicked))
        
        let shoot = UIAction(title: "사진 촬영", image: nil, handler: { _ in print("사진 촬영") })
        let gallery = UIAction(title: "갤러리", image: nil, handler: { _ in print("갤러리") })
        let cancel = UIAction(title: "취소", image: nil, handler: { _ in print("취소") })
        
        details.menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [shoot, gallery, cancel])
    }
    
    func showActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let shoot = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            print("SHOOT CLICKED")
        }
        let gallery = UIAlertAction(title: "갤러리", style: .default) { _ in
            print("GALLERY CLICKED")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("CANCEL CLICKED")
        }
        alert.addAction(shoot)
        alert.addAction(gallery)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension SearchImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchImageCollectionViewCell", for: indexPath) as? SearchImageCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: imageArray[indexPath.item])
        cell.photoImage.kf.setImage(with: url)
        cell.photoImage.tag = indexPath.item
        return cell
    }
    
    //셀선택시 박스표시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        if let cell = collectionView.cellForItem(at: indexPath) as? SearchImageCollectionViewCell {
            cell.showSelectionBox()
            self.selectedImageIndex = indexPath.item //프로퍼티에 인덱스 담아 didSelectItemAt외부에서 사용할수있도록 만듦
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
        searchBar.resignFirstResponder()
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
