//
//  URL+Extension.swift
//  Week6_Assignment
//
//  Created by Mac Pro 15 on 2022/09/17.
//

import Foundation

extension URL {
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
}
