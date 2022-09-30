//
//  DiaryViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/29.
//

import UIKit

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
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveRightBarButtonItemClickedNotification(notification:)), name: NSNotification.Name("saveRightBarButtonItemClickedNotification"), object: nil)
    
    }
    
    @objc func saveRightBarButtonItemClickedNotification() {
        
    }
    
}
