//
//  ViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/24.
//

import UIKit
import SeSAC_UIFramework

var name = "고래밥"

private var age = 22

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        testOpen()
//        showSeSACAlert(title: "테스트얼럿", message: "테스트메시지", buttonTitle: "변경") { _ in
//            self.view.backgroundColor = .lightGray
//        }
        
        let image = UIImage(systemName: "star.fill")!
        let shareURL = "https://www.apple.com"
        let text = "WWDC What's New!!!"
        //sesacActivityViewController(shareImage: image, shareURL: shareURL, shareText: text)
        
        //let web = OpenWebView() // open인데도 왜 접근이 안되는지?
        OpenWebView.presentWebViewController(self, url: "https://www.apple.com", transitionStyle: .present)
    }
}

