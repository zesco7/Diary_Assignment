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
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"] //계속 반복될 코드이기 때문에 따로 빼서 사용해도 됨.
    
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
    
    //타입별로 가지고 있는 json데이터가 다를 것이기 때문에 json이 가지고 있는 여러 데이터 중 필요한 데이터만 뽑기 위해 탈출클로저 사용(completionHandler)
    //인자값으로 json이 가지고 있는 데이터를 보내야하기 때문에 타입도 JSON이 된다.
    func callRequest2(type: EndPoint, query: String, completionHandler: @escaping (JSON) -> () ) {
        print(#function)
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestURL + query
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                completionHandler(json) //외부에서 사용할 액션 내용
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
