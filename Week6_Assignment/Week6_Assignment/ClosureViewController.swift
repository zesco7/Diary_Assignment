//
//  ClosureViewController.swift
//  Week6_Assignment
//
//  Created by Mac Pro 15 on 2022/09/18.
//

import UIKit

class ClosureViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func colorPickerButtonClicked(_ sender: UIButton) {
        showAlert(title: "컬러피커를 띄우겠습니까?", message: nil, okTitle: "띄우기")
        showAlert2(title: "컬러피커를 띄우겠습니까?", message: nil, okTitle: "띄우기") {
            let picker = UIColorPickerViewController() //UIFontPickerViewController
            present(picker, animated: true)
    }
    }
    @IBAction func backgroundColorChanged(_ sender: UIButton) {
        showAlert(title: "배경색 변경", message: "배경색을 바꾸시겠습니까?", okTitle: "바꾸기")
        showAlert2(title: "배경색 변경", message: "배경색을 바꾸시겠습니까?", okAction: "바꾸기")
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { action in //액션정보 전달
            print(action.title)
            self.view.backgroundColor = .gray
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}

extension UIViewController {
    func showAlert(title: String, message: String?, okTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: okTitle, style: .default) { action in //액션정보 전달
            print(action.title)
            self.view.backgroundColor = .gray
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
        
        
    }
    
    func showAlert2(title: String, message: String?, okAction: () -> () ) { //클로져 사용
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: okAction, style: .default) { action in //액션정보 전달
            okAction()
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
        
        
    }
}

