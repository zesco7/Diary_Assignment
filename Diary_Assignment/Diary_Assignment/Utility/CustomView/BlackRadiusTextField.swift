//
//  BlackRadiusTextField.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/28.
//

import UIKit

class BlackRadiusTextField: UITextField {
    override init(frame: CGRect) { //뷰객체이기 때문에 초기화해야 디폴트값을 설정할 수 있음.
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .clear
        textAlignment = .center
        borderStyle = .none
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        textColor = .black
    }
}
