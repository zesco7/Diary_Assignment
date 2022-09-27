//
//  ProfileViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/27.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.backgroundColor = .black
        return view
    }()
    
    let nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "이름을 입력하세요"
        view.backgroundColor = .brown
        view.textColor = .white
        return view
    }()
    
    func configure() {
        [saveButton, nameTextField].forEach {
            view.addSubview($0)
        }
        
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(50)
            $0.top.equalTo(50)
            $0.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.center.equalTo(view)
        }
    }
    
    //옵셔널 지정이유? ProfileViewController 화면 뜰 때 옵셔널아니면 앱꺼질수 있으므로 nil값 받을 수 있게 함.
    var saveButtonActionHandler: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .yellow
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    //saveButtonActionHandler는 함수 자체임. 실행해주려면 뒤에 괄호 붙여야함.(함수생성과 호출을 구분해둔 것임)
    //ViewController에서 nameButton값을 가져오려면 인스턴스생성을 해주어야하는데 그것보다는 애초에 ViewController에서 클로저를 통해 값을 넘겨주는 방식으로 처리하는 것임. 그렇지 않으면 저장버튼을 누르기도 전에 화면 전환과 동시에 nameButton타이틀이 표시되기 때문.(즉, 데이터저장시점과 호출시점을 구분한 것임)
    @objc func saveButtonClicked() {
        
        //값전달 방식1. Closure(호출하는 시점에 실행되도록 만들 수 있다)
        saveButtonActionHandler?() //saveButtonActionHandler자체가 옵셔널이기 때문에 ? 붙임
        
        //화면 dismiss
        dismiss(animated: true)
    
    }
}
