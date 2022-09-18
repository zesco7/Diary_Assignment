//
//  Test.swift
//  RealmTest
//
//  Created by bro on 2022/09/18.
//

import Foundation

import SwiftyJSON

//Example.
/*
 - 설명
    동물에 대한 정보를 받아오는 api에서 값을 받아와서 출력해보려고 합니다.
    받아온 동물들의 타입에 대해서 모두 출력하세요.
 
 - 출력예시
    animal은 dog, animalType은 3, 4입니다.
 */

func example() {
    //아래 주석을 해제하여 문제를 해결해주세요!
    let jsonExample =
    {
        "page": 1,
        "totalResults": 4,
        "results": [{
                "animalType": [
                    1,
                    2,
                    3,
                    4
                ],
                "animal": "cat"
            },
            {
                "animalType": [
                    4,
                    5
                ],
                "animal": "dog"
            },
            {
                "animalType": [
                    3,
                    4
                ],
                "animal": "bird"
            },
            {
                "animalType": [
                    6
                ],
                "animal": "elephant"
            }
        ]
    }
    
    
}

 guard let data = jsonExample.data(using: .utf8, allowLossyConversion: false) else { return  }
 let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
 
 let json = JSON(jsonObject)

 for item in json["results"].arrayValue {
     let animal = item["animal"].stringValue
     let typeArray = item["animalType"].arrayValue
 
     var animalType: [Int] = []
     for type in typeArray {
         animalType.append(type.intValue)
     }
     print("animal은 \(animal), animalType은 \(animalType)입니다.")
 }
 
