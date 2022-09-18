//
//  APIKey.swift
//  Week6_Assignment
//
//  Created by Mac Pro 15 on 2022/09/17.
//

import Foundation

/*APIKey 생성 관련
 -. enum으로 APIKey생성하는것을 권장함. struct도 쓸 수는 있으나 타입프로퍼티임에도 다른 뷰컨트롤러에서 불필요하게 인스턴스를 생성해서 사용할 수 있기 때문임
 -. enum일때 중복값 생성 피하기 위해 case보다 static사용 권장(case는 중복가능하기때문
 -. APIKey를 다른 컴퓨터에서 작업할때 property list로 API Configuration 만들어 사용하는 편(코드흐름은 유지한채 키만 추출할 수 있음)
 */
enum APIKey {
    static let kakao = "1ce91d9049e5547a9ff92ffb1f900f99"
}
