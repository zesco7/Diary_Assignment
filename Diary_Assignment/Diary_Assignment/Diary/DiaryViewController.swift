//
//  DiaryViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/29.
//

import UIKit
import Kingfisher

/*질문
 -.NotificationCenter.default.addObserver로 사진URL받아서 네트워크다시요청하는건지 사진자체를 받아오는건지? 사진자체만 받아오려면 어떻게 하는지?
 
 */

class DiaryViewController: BaseViewController {
    
    let mainView = DiaryView()
    //let navi = UINavigationController(rootViewController: DiaryViewController())
    
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
    }
    
    @objc func selectionRightBarButtonItemClickedNotification(notification: NSNotification) {
        if let savedImageURL = notification.userInfo?["savedImageURL"] as? String {
            print(savedImageURL)
            let url = URL(string: savedImageURL)
            self.mainView.photoImageView.kf.setImage(with: url)
        }
    }
}
