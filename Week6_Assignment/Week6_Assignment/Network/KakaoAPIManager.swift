//
//  KakaoAPIManager.swift
//  Week6_Assignment
//
//  Created by Mac Pro 15 on 2022/09/18.
//

import Foundation

import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    static let shared = KakaoAPIManager() //싱글톤 패턴
    
    private init() { }
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"]
    
    func callRequest(type: EndPoint, query: String) {
        print(#function)
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestURL + query
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callRequest2(type: EndPoint, query: String, completionHandler: @escaping (JSON) -> () ) {
        print(#function)
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestURL + query
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
