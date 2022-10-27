//
//  Observable.swift
//  Practice
//
//  Created by Mac Pro 15 on 2022/10/17.
//

import Foundation
//데이터가 변경되었을때 특정 명령 수행

class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didset", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
     
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value)
        listener = closure
    }
}

class User {
    
    private var listener: ((String) -> Void)?
    
    var value: String {
        didSet {
            print("데이터 변경됨")
            listener?(value)
        }
    }
    
    init(value: String) {
        self.value = value
    }
}
