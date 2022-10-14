//
//  MemoListView.swift
//  Memo_Assessment
//
//  Created by Mac Pro 15 on 2022/10/09.
//

import Foundation
import UIKit

class MemoListView: BaseView {
    
    let totalCount : UILabel = {
        let view = UILabel()
        return view
    }()
    
    let tableView : UITableView = {
       let view = UITableView()
        view.backgroundColor = .yellow
        return view
    }()
    
    override func configureUI() {
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.size.equalTo(self)
        }
    }
}
