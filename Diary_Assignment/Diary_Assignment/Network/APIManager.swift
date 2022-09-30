//
//  APIManager.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/29.
//

import Foundation
import Alamofire
import SwiftyJSON

class ImageSearchAPIManager {
    static var shared = ImageSearchAPIManager()
    private init() { } //초기화 방지용 접근제어 선언
    
    func fetchImageData(query: String, completionHandler: @escaping (Int, [String]) -> () ) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! //텍스트는 String?타입이므로 언래핑해줌
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        let url = "\(EndPoint.naverURL)?query=\(text)&display=50&start=1&sort=sim"
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    //print("JSON: \(json)")
                    
                    let totalCount = json["total"].intValue
                    let link = json["items"].arrayValue.map { $0["link"].stringValue }
                    
                    print(totalCount)
                    print(link)
                    
                    completionHandler(totalCount, link)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
}
