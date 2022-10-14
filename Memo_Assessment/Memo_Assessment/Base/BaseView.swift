//
//  BaseView.swift
//  Memo_Assessment
//
//  Created by Mac Pro 15 on 2022/10/09.
//

import UIKit

import RealmSwift
import SnapKit
import Toast

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() { }
    func setConstraints() { }
}
