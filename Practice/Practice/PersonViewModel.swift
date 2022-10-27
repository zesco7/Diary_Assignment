//
//  PersonViewModel.swift
//  Practice
//
//  Created by Mac Pro 15 on 2022/10/17.
//

import Foundation

class PersonViewModel {
    
    var list: Observable<Person> = Observable(Person(page: 0, totalPages: 0, totalResults: 0, results: []))
    
    var numberOfRowsInSection: Int {
        //제네릭을 사용한 Observable 때문에 list.results 가 아니라 list.value.results로 접근
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) - > Result {
        return list.value.results[indexPath.row]
    }
    
    func fetchPerson(query: String) {
        PersonAPIManager.requestPerson(query: "kim") { person, error in //한글로 통신요청하면 에러
            guard let person = person else {
                return
            }
            dump(person)
            self.list.value = person
        }
    }
    }
    
    //뷰컨트롤러에 있는 네트워크통신 메서드를 뷰모델로 이동
    
    

}
 
/*
 리스트를 뷰모델에서 전달받을거기 때문에 뷰컨트롤러에서 생성안할 것임.
 //데이터를 모델에서 가져오는게 아니라 뷰모델에서 가져온다.
 */
