//
//  DiaryViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/29.
//

import UIKit
import Kingfisher
import RealmSwift //Realm1. 라이브러리 추가

/*Realm데이터 저장 순서
 1. 라이브러리 추가
 2. 파일 저장경로 설정
 3. 레코드 생성, 추가
 4. 파일 저장경로 확인
 */

/*질문
 -.tapDone에서 datePicker 타입을 Date로 어떻게 바꾸는지? 방법몰라 realm테이블 컬럼타입을 string으로 바꿔서 처리함.
 
 */

protocol SelectImageDelegate { //protocol사용하여 데이터전달1. protocol생성
    func sendImageData(image: UIImage)
}

class DiaryViewController: BaseViewController {
    //let navi = UINavigationController(rootViewController: DiaryViewController())
    let mainView = DiaryView()
    
    //Realm2. 파일 저장경로 설정
    let localRealm = try! Realm() //realm테이블에 내용 CRUD할때 Realm테이블에 접근하도록 만들기(localRealm은 테이블경로)
    
    override func loadView() {
        self.view = mainView
        mainView.searchImageButton.addTarget(self, action: #selector(searchImageButtonClicked), for: .touchUpInside)
    }
    
    @objc func searchImageButtonClicked() {
        let vc = SearchImageViewController()
        vc.delegate = self //프로토콜 연결(프로토콜 선언하면 상속받은 타입속성을 지니기 때문에 SearchImageViewController에서 delegate가 SelectImageDelegate타입이어도 괜찮음)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(customGallerySelectionUIMenuClickedNotification(notification:)), name: NSNotification.Name("customImage"), object: nil)
        
        //Realm4. 파일 저장경로 출력(원래 샌드박스처럼 파일저장경로를 알 수는 없지만 Realm에서 코드 제공)
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelBarButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveBarButtonClicked))
        
        self.mainView.dateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
        if let datePicker = self.mainView.dateTextField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "YYYY-MM-dd (EEE)"
            self.mainView.dateTextField.text = dateformatter.string(from: datePicker.date)
        }
        self.mainView.dateTextField.resignFirstResponder()
    }
    
    @objc func cancelBarButtonClicked() {
        //dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    //realm+이미지 도큐먼트 저장
    @objc func saveBarButtonClicked() {
        
        if mainView.titleTextField.text == "" {
            let alert = UIAlertController(title: "제목을 입력하세요", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        } else {
            //Realm3. 레코드 생성, 추가
            //레코드 생성
            let task = UserDiary(diaryTitle: mainView.titleTextField.text!, diaryContents: mainView.contentTextView.text, diaryDate: mainView.dateTextField.text!, regDate: Date(), favorite: false, photo: nil)
            
            //레코드 추가
            //저장하려는 레코드 생성+realm에 이미지 저장+document에 이미지 저장
            do {
                try localRealm.write {
                    localRealm.add(task)
                }
            } catch let error {
                print(error)
            }
            
            //사진이 있으면 도큐먼트에 이미지 저장
            if let image = mainView.photoImageView.image {
                saveImageToDocument(fileName: "\(task.objectId).jpg", image: image) //realm모델에서 self.init()구문 때문에 pk자동생성되어 objectId에 접근할 수 있음.
                print("Realm Success")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func customGallerySelectionUIMenuClickedNotification(notification: NSNotification) {
        if let customImage = notification.userInfo?["customImage"] as? UIImage {
            self.mainView.photoImageView.image = customImage
        }
    }
}

extension UITextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
        //데이터피커 생성
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        self.inputView = datePicker
        
        //툴바 생성
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}

extension DiaryViewController: SelectImageDelegate {
    func sendImageData(image: UIImage) {
        mainView.photoImageView.image = image
        print(#function)
    }
}

