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
        //testPrivate()
        showSeSACAlert(title: "테스트얼럿", message: "테스트메시지", buttonTitle: "변경") { _ in
            self.view.backgroundColor = .lightGray
        }
    }


}

