//
//  week9VC.swift
//  Practice
//
//  Created by Mac Pro 15 on 2022/10/17.
//

import Foundation

//컨트롤러에서 데이터를 직접 가지고 있음
var list: Person = Person(page: 0, totalPages: 0, totalResults: 0, results: [])
-->
//컨트롤러에서 데이터를 직접 가지고 있는게 아니라 뷰모델을 통해 데이터를 가지고 있음
private var viewModel =  PersonViewModel()





viewModel.fetchPerson(query: "kim")
viewModel.list.bind { person in
    print("viewcontroller bind")
    self.tableView.reloadData()
}
