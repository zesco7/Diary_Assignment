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
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(selectionRightBarButtonItemClickedNotification(notification:)), name: NSNotification.Name("savedImageURL"), object: nil)
        
        //Realm4. 파일 저장경로 출력(원래 샌드박스처럼 파일저장경로를 알 수는 없지만 Realm에서 코드 제공)
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelBarButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveBarButtonClicked))
    }
    
    @objc func cancelBarButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveBarButtonClicked() {
        //Realm3. 레코드 생성, 추가
            //레코드 생성
            let task = UserDiary(diaryTitle: "오늘의 일기\(Int.random(in: 1...100))", diaryContents: "일기 테스트 내용", diaryDate: Date(), regDate: Date(), favorite: false, photo: nil)
            
            //레코드 추가
            try! localRealm.write {
                localRealm.add(task)
                print("Realm Success")
                self.navigationController?.popViewController(animated: true)
            }
    }
    
    @objc func selectionRightBarButtonItemClickedNotification(notification: NSNotification) {
        if let savedImageURL = notification.userInfo?["savedImageURL"] as? String {

            //self.mainView.photoImageView.image = savedImageURL
            print(savedImageURL)
            let url = URL(string: savedImageURL)
            self.mainView.photoImageView.kf.setImage(with: url)
        }
    }
}
