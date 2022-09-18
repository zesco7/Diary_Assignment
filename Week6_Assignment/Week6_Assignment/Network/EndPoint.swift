//
//  EndPoint.swift
//  Week6_Assignment
//
//  Created by Mac Pro 15 on 2022/09/17.
//

import Foundation
//enum에서 저장프로퍼티는 못쓰고 연산프로퍼티만 사용 가능 한 이유는?
//-> 저장프로퍼티는 초기화 구문 생성할 수 있는 형태에서만 사용 가능(enum은 초기화 못하니까)
//-> enum안에 연산프로퍼티가 있어도 사용하는 viewcontroller쪽에서 공간을 차지 하기 때문에 연산프로퍼티 사용 가능(메서드처럼 작동한다)
enum EndPoint {
    //static let blog = "\(URL.baseURL)blog"
    //static let cafe = "\(URL.baseURL)cafe"
    
    case blog
    case cafe
    
    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case .cafe:
            return URL.makeEndPointString("cafe?query=")
        }
    }
    
}
