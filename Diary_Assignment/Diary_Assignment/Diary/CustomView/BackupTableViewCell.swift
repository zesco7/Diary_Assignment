//
//  BackupTableViewCell.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/08.
//

import UIKit

class BackupTableViewCell: UITableViewCell {
    static var identifier = "BackupTableViewCell"
    
    let backupDataLabel : UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .bold)
       return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        self.contentView.addSubview(backupDataLabel)
    }
    
    func setConstraints() {
        backupDataLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
        }
    }
}
