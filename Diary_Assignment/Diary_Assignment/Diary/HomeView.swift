//
//  HomeView.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/08.
//

import UIKit
import SwiftUI

import FSCalendar

class HomeView: BaseView {
    let searchBar : UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "일기내용을 검색하세요"
        return view
    }()
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = .white
        return view
    }()
    
    let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
       return dateFormatter
    }()
    
    override func configureUI() {
        [searchBar, tableView, calendar].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.width.equalTo(self)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.width.equalTo(self)
            make.height.equalTo(self)
        }
        
        calendar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
    }
}
