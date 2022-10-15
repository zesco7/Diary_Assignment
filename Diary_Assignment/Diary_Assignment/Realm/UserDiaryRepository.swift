//
//  UserDiaryRepository.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/14.
//

import Foundation
import RealmSwift
import UIKit

//프로토콜 통해서 세부적으로 코드 보지 않고도 어떤메서드가 들어있는지 한눈에 알 수 있음
//realm테이블이 여러개 일 때 프로토콜 연결해서 사용할 수도 있음
protocol UserDiaryRepositoryType {
    func fetch() -> Results<UserDiary>
    func fetchSort(_ sort: String) -> Results<UserDiary>
    func fetchDate(date: Date) -> Results<UserDiary>
    func fetchFilter() -> Results<UserDiary>
    func updateFavorite(item: UserDiary)
    func addItem(item: UserDiary) //나중에 사용할 프로토콜을 먼저 만들어놓으면 다른 사람이 용도를 쉽게 이해할 수 있고 세부사항을 구현만 해주면 된다.
}

class UserDiaryRepository: UserDiaryRepositoryType {
    func fetchDate(date: Date) -> Results<UserDiary> {
        //%@: NSPredicate에 의해 매개변수 의미
        //diaryDate >= %@에서 %@은 메서드에서 받은 date이고 diaryDate < %@에서 %@은 뒤에 +86400초 추가된 date임
        //FSCalendar 날짜 기본타입은 시분초까지 제공함.
        return localRealm.objects(UserDiary.self).filter("diaryDate >= %@ AND diaryDate < %@", date, Date(timeInterval: 86400, since: date))
    }
    
    func addItem(item: UserDiary) { //realm레코드 추가할 때 사용
        print(#function)
    }
    
    let localRealm = try! Realm()
    
    //Results형식인 realm데이터를 반환해야하므로 함수 리턴타입 추가
    func fetch() -> Results<UserDiary> {
        return  localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: true)
    }
    
    func fetchSort(_ sort: String) -> Results<UserDiary> {
        return  localRealm.objects(UserDiary.self).sorted(byKeyPath: sort, ascending: false)
    }
    
    func fetchFilter() -> Results<UserDiary> {
        return  localRealm.objects(UserDiary.self).filter("favorite == true")
    }
    
    func updateFavorite(item: UserDiary){
        try! localRealm.write {
            //하나의 레코드에서 특정컬럼 하나만 변경
            item.favorite = !item.favorite
            //item.favorite.toggle()
            
            //하나의 레코드에서 컬럼 전체 변경
            //self.tasks.setValue(false, forKey: "favorite")
            
            //하나의 레코드에서 여러 컬럼 변경(변경하려는 컬럼 전에 구분용으로 pk를 넣어주어야 함)
            //                self.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectId, "diaryContent": "변경테스트", "diaryTitle": "제목임", update: .modified)
            
            print("Realm Update Succeeded")
        }
    }
    
    func deleteItem(item: UserDiary) {
        //사진 먼저 지우고 렘 지우면 문제가 안생겼던 이유? -> 사진을 지우고 레코드를 지우면 사진에 해당하는 인덱스가 삭제 되고 남은 배열로 인덱싱을 하기 때문에 내가 선택한 것이 아니라 다음 것이 삭제됨
        //해결방법? 1. 사진 먼저 삭제하고 렘 삭제 2.self.tasks[indexPath.row]를 프로퍼티로 만들면 레코드를 삭제해도 프로퍼티에 남은 인덱스값을 사용가능(코드가독성 + 데이터정합성)
        //object has been deleted or invalidated 에러 해결방법?
        
        removeImageFromDocument(fileName: "\(item.objectId).jpg")
        
        try! self.localRealm.write {
            self.localRealm.delete(item)
        }
        
        
        //            tableView.beginUpdates()
        //            tableView.endUpdates()
        
        //            let task = self.tasks[indexPath.row]
        //
        //            try! self.localRealm.write {
        //                self.localRealm.delete(task)
        //            }
        //
        //            self.removeImageFromDocument(fileName: "\(task.objectId).jpg")
        //            self.fetchRealm()
    }
    
    //도큐먼트 이미지파일삭제 메서드
    func removeImageFromDocument(fileName: String){
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //실행중인 앱의 document 경로를 documentDirectory에 대입
        let fileURL = documentDirectory.appendingPathComponent(fileName) //document안에 저장된 fileName의 경로(이미지 저장 경로)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
}
