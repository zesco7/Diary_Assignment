//
//  BackupView.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/08.
//

import UIKit

class BackupView: BaseView {
    let backupButton : UIButton = {
        let view = UIButton()
        view.setTitle("백업", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        view.layer.borderWidth = 1
        view.layer.backgroundColor = UIColor.blue.cgColor
       return view
    }()
    
    let restorationButton : UIButton = {
        let view = UIButton()
        view.setTitle("복구", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        view.layer.borderWidth = 1
        view.layer.backgroundColor = UIColor.orange.cgColor
       return view
    }()
    
    let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .brown
        return view
    }()
    
    override func configureUI() {
        [backupButton, restorationButton, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        backupButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self).offset(100)
            make.size.equalTo(80)
        }
        
        restorationButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self).offset(-100)
            make.size.equalTo(80)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backupButton.snp.bottom).offset(80)
            make.leading.equalTo(self)
            make.width.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
