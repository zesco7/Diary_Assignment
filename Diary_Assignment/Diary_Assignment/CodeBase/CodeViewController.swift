//
//  CodeViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/26.
//

import UIKit

/*코드베이스 순서
 1. 뷰객체 인스턴스 생성: 사용할 기능을 정하는 작업
 2. 서브뷰 추가: 화면에 표시하는 작업
 3. 속성 설정: Frame기반 설정에 한계를 개선하기 위해 AutoResizingMask, AutoLayout, NSLayoutConstraints 등장함
 */
class CodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //코드베이스1. 뷰객체 인스턴스 생성: 사용할 기능을 정하는 작업
        let emailTextField = UITextField()
        let passwordTextField = UITextField()
        let signButton = UIButton()
        
        //코드베이스2. 서브뷰 추가: 화면에 표시하는 작업
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signButton)
        
        //코드베이스3. 속성 설정
        //Frame기반
        emailTextField.frame = CGRect(x: 50, y: 50, width: UIScreen.main.bounds.width - 90, height: 50)
        emailTextField.borderStyle = .line
        emailTextField.backgroundColor = .lightGray
        
        //NSLayoutConstraints 기반
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = .lightGray
        
//        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 120)
//        top.isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
        
        //NSLayoutConstraints + addConstraints기반
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 120)
        
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
        
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50)
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        
        view.addConstraints([top, leading, trailing, height])
        
        //NSLayoutAnchor 기반
    }
    
    
    

}
