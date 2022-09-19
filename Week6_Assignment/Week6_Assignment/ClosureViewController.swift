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
            self.present(picker, animated: true)
        }
    }
    @IBAction func backgroundColorChanged(_ sender: UIButton) {
        showAlert(title: "배경색 변경", message: "배경색을 바꾸시겠습니까?", okTitle: "바꾸기")
        showAlert2(title: "배경색 변경", message: "배경색을 바꾸시겠습니까?", okTitle: "바꾸기") {
            self.view.backgroundColor = .gray
        }
        showAlert2(title: <#T##String#>, message: <#T##String?#>, okTitle: <#T##String#>) { 
            <#code#>
        }
        
    }
}

/*익스텐션 사용 관련
 -. 여러번 사용할 함수코드 중복 제거
 -. 같은 함수 실행해도 매개변수 통해 다른 alert내용 표시 가능
 -. 탈출클로저 사용하면 외부에서 함수 실행 가능
 */
extension UIViewController {
    //확인버튼 클릭시 추가기능X
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
    //확인버튼 클릭시 추가기능X(okAction눌렀을 때 okAction메서드 실행)
    //showAlert에서는 함수마다 동일한 액션이 적용된다.(self.view.backgroundColor = .gray) 중첩함수에서 다른 액션을 실행하고 싶을 때 클로저를 사용해서 처리할 수 있다.
    //클로저는 함수내에서 직접실행을 해야하는 탈출불가 성격이 있다. 이때 @escaping을 붙여주면 탈출가능한 인자값으로 인식되어 변수나 상수에 클로저를 대입하거나 중첩함수내부에서 사용할 수 있다.
    func showAlert2(title: String, message: String?, okTitle: String, okAction: @escaping () -> () ) { //클로져 사용
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: okTitle, style: .default) { action in //액션정보 전달
            okAction()
            let nn = UIAlertAction(title: "", style: .default) { <#UIAlertAction#> in
                <#code#>
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
        
        
    }
}

