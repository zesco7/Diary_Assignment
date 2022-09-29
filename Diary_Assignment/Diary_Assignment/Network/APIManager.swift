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
    
    func fetchImageData(data: String) {
        let url = "\(EndPoint.naverURL)?query=\(data)"
            AF.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
}
