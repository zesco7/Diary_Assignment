//
//  HomeView.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/08.
//

import UIKit
import SwiftUI

class HomeView: BaseView {
    let searchBar : UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "일기내용을 검색하세요"
        return view
    }()
    
    let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func configureUI() {
        [searchBar, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(self)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.width.equalTo(self)
            make.height.equalTo(self)
        }
    }
}
