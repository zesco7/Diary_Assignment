//
//  WriteViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/28.
//

import UIKit
import SnapKit

class WriteViewController: BaseViewController {
    
    var mainView = WriteView()
    
    override func loadView() { //뷰를 루트뷰로 변경해주는 메서드(super.loadView 선언하지 않음)
        self.view = mainView
    }
    
    override func viewDidLoad() { //루트뷰를 메모리에 올리고 viewDidLoad실행되기 때문에 루트뷰 자체를 loadView로 먼저 바꿔준다.
        super.viewDidLoad()
        
    }
    
    override func configure() {
        mainView.titleTextField.addTarget(self, action: #selector(titleTextFieldClicked(_:)), for: .editingDidEndOnExit)
    }

    @objc func titleTextFieldClicked(_ textField: UITextField) {
        guard let text = textField.text, text.count > 0 else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
    }
}
