//
//  SearchImageViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/29.
//

import UIKit

import Kingfisher
import Photos
import PhotosUI

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
 -. customImage전달할때 property사용하면 왜 데이터가 안뜨는지?
 */

/*포인트
 -. 서버통신할때 다른 작업 못하도록 isUserInteractionEnabled처리 해두는게 좋음. 서버통신 끝나면 정상작동 가능하도록 할 수 있음. (ex.view.isUserInteractionEnabled = false)
 */
class SearchImageViewController: BaseViewController {
    
    let picker = UIImagePickerController()
    var delegate: SelectImageDelegate? //protocol사용하여 데이터전달1. protocol 변수 선언
    var selectImage: UIImage? //protocol사용하여 데이터전달2. 전달할 데이터 변수 선언
    
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
        picker.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoOption()
    }
    
    //바버튼 사진옵션 적용(UIMenu, ActionSheet)
    func photoOption() {
        var menuItems: [UIAction] {
            return [
                UIAction(title: "사진 촬영", image: nil, attributes: .disabled, handler: { _ in print("사진 촬영") }), //PHPicker는 촬영기능 안돼서 disabled처리
                UIAction(title: "갤러리", image: nil, handler: { _ in
                    self.openGallery()
                    print("갤러리") }),
                UIAction(title: "취소", image: nil, handler: { _ in print("취소") }) //.destructive 등 attributes 추가 가능
            ]
        }
        
        var customImageMenu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: menuItems)
        }
        
        if #available(iOS 14.0, *) {
            let details = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: customImageMenu)
            let selection = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectionRightBarButtonItemClicked))
            navigationItem.rightBarButtonItems = [details, selection]
        } else {
            let details = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(detailsRightBarButtonItemClicked))
            let selection = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectionRightBarButtonItemClicked))
            navigationItem.rightBarButtonItems = [details, selection]
        }
    }
    
    @objc func detailsRightBarButtonItemClicked() {
        self.showActionSheet()
    }
    
    @objc func selectionRightBarButtonItemClicked() {
        print(#function)
        let vccell = SearchImageCollectionViewCell()
        
        //        NotificationCenter.default.post(name: NSNotification.Name("savedImage"), object: nil, userInfo: ["savedImage": vc.photoImage.image) //타입캐스팅 어떻게?
        if let isNotNil = selectedImageIndex {
            delegate?.sendImageData(image: selectImage!) //protocol사용하여 데이터전달4. didSelectItemAt에서 받은 이미지를 인자로 넣어 프로토콜 메서드 호출
            self.navigationController?.popViewController(animated: true)
            
//            NotificationCenter.default.post(name: NSNotification.Name("savedImageURL"), object: nil, userInfo: ["savedImageURL": imageArray[selectedImageIndex!]])
//                self.navigationController?.popViewController(animated: true)
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
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "사진 촬영", image: nil, handler: { _ in print("사진 촬영") }),
                UIAction(title: "갤러리", image: nil, handler: { _ in print("갤러리") }),
                UIAction(title: "취소", image: nil, handler: { _ in print("취소") })
            ]
        }
        
        var customImageMenu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: menuItems)
        }
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
        cell.layer.borderColor = selectedImageIndex == indexPath.item ? UIColor.yellow.cgColor : nil
        cell.layer.borderWidth = selectedImageIndex == indexPath.item ? 5 : 0
        
        return cell
    }
    
    //셀선택시 박스표시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        self.selectedImageIndex = indexPath.item //프로퍼티에 인덱스 담아 didSelectItemAt외부에서 사용할수있도록 만듦(NotificationCenter에서 사용)
            
            //protocol사용하여 데이터전달3.cellForItemAt에서 재사용셀에 있는 이미지데이터 가져오기
            guard let cell = collectionView.cellForItem(at: indexPath) as? SearchImageCollectionViewCell else { return }
            //cell.showSelectionBox()
            selectImage = cell.photoImage.image
            collectionView.reloadData()
        }
    
    //셀선택시 박스제거
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SearchImageCollectionViewCell else { return }
            cell.hideSelectionBox()
            //collectionView.reloadData()
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

extension SearchImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
}

@available(iOS 14.0, *) //iOS 14 이상일 때
extension SearchImageViewController: PHPickerViewControllerDelegate {
    func openGallery() {
        var configuration = PHPickerConfiguration() //PHPicker객체 구현
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])
        
        let picker = PHPickerViewController(configuration: configuration) //PHPickerViewController에 PHPicker객체넣기
        picker.delegate = self //PHPickerViewController 프로토콜 연결
        self.present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let itemProvider = results.first?.itemProvider //itemProvider불러오기(선택한 asset의 대표)
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) { //선택한 asset이 nil이 아니고, 타입이 UIImage일 때 불러오기
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {                    

                    //NotificationCenter사용하여 데이터전달
                    NotificationCenter.default.post(name: NSNotification.Name("customImage"), object: nil, userInfo: ["customImage": image])
                    picker.dismiss(animated: true)
                    self.navigationController?.popViewController(animated: true)
                    print("저장된 사진 불러오기를 성공했습니다.")
                }
            }
        } else {
            picker.dismiss(animated: true)
        }
    }
}
