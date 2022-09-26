//
//  CodeSnap2ViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/26.
//

import UIKit
import SnapKit

class CodeSnap2ViewController: UIViewController {
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        [redView, blackView].forEach {
            view.addSubview($0)
        }
        
        redView.addSubview(yellowView) //뷰에 서브뷰를 추가할 수 있음(뷰 계층구조 나눌 때 사용)
        
        redView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
        }
        
        blackView.snp.makeConstraints { make in
            make.edges.equalTo(redView).inset(50)
        }
        
        yellowView.snp.makeConstraints { make in
            make.edges.equalTo(redView).offset(10)
        }


    }
    
}
