//
//  MemoListTableViewCell.swift
//  Memo_Assessment
//
//  Created by Mac Pro 15 on 2022/10/09.
//

import UIKit

class MemoListTableViewCell: UITableViewCell {
    let titleLabel : UILabel = {
        let view = UILabel()
        return view
    }()
    
    let lastEditedDateLabel : UILabel = {
        let view = UILabel()
        return view
    }()
    
    let contentsLabel : UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [titleLabel, lastEditedDateLabel, contentsLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.width.equalTo(self)
            make.height.equalTo(20)
        }
        
        lastEditedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.width.lessThanOrEqualTo(100)
            make.height.equalTo(20)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(lastEditedDateLabel.snp.trailing).offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(20)
        }
    }
}
