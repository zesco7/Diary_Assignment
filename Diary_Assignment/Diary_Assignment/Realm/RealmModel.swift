//
//  RealmModel.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/01.
//

import Foundation
import RealmSwift

/*Realm순서
 1.테이블 만들기: 컬럼생성해서 테이블 내용을 작성하기
 2.PK(Primary Key)만들기: 테이블이름 생성해서 테이블 구분하기
 3.초기화
 
 @참고
 -. 인덱싱: 검색속도를 높이기 위해 특정 요소에 인덱싱 할 수 있으나 인덱싱을 많이하면 오히려 느려지기 때문에 필요한 요소만 하는게 좋다.
 -. 테이블 구조 만들면 테이블이 생기는 것이 아니라 데이터를 저장하면 그때 테이블과 파일이 생성됨.
 */

//UserDiary: 테이블 이름, @Persisted: 컬럼
class UserDiary: Object {
    //Realm1. 테이블 만들기
    @Persisted var diaryTitle: String //제목(필수)
    @Persisted var diaryContents: String? //내용(옵션)
    @Persisted var diaryDate: String //작성날짜(필수)
    @Persisted var regDate = Date() //등록날짜(필수)
    @Persisted var favorite: Bool //즐겨찾기(필수)
    @Persisted var photo: String? //사진URL(옵션)
    
    //Realm2. PK(필수) 등록: Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    //Realm3. 초기화
    convenience init(diaryTitle: String, diaryContents: String, diaryDate: String, regDate: Date, favorite: Bool, photo: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContents = diaryContents
        self.diaryDate = diaryDate
        self.regDate = regDate
        self.favorite = false
        self.photo = photo
    }
}
