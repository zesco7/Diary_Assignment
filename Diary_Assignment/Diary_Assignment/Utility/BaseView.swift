//
//  BaseView.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/28.
//

import UIKit
import SnapKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }

    /*init
     -.init(frame)은 코드베이스에서 호출되고, init(coder)는 스토리보드,xib,프로토콜에서 호출된다.
     -.코드베이스여도 required init?(coder: NSCoder)이 호출은 되지만 실행은 안됨. 스토리보드,xib,프로토콜에서 실행됨.
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") //fatalError뜨면 런타임 오류 발생함.
    }
    
    func configureUI() { }
    
    func setConstraints() { }
}


//MARK: - required initializer
protocol example {
    init(name: String)
}

class Mobile: example {
    let name: String
    
    required init(name: String) { //초기화구문 가진 프로토콜을 채택할때는 init 앞에 required를 붙여줘서 초기화구문이 프로토콜에서 있었다는걸 구분해준다.
        self.name = name
    }
}

class Apple: Mobile {
    let wwdc: String
    
    init(wwdc: String) {
        self.wwdc = wwdc  //초기화 순서 지키기: 자기자신 초기화 먼저하고 부모 프로퍼티 초기화 해야함.
        super.init(name: "야호") //상속받았기 때문에 부모클래스 초기화구문도 불러줘야함.
    }
    
    required init(name: String) {
        fatalError("init(name:) has not been implemented")
    }
}

let a = Apple(wwdc: "안녕")

