//
//  HomeTableViewCell.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/08.
//

import UIKit

import SnapKit

class HomeTableViewCell: UITableViewCell {
    static var identifier = "HomeTableViewCell"
    
    let diaryImage : UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
       return view
    }()
    
    let diaryTitle : UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .bold)
       return view
    }()
    
    let diaryDate : UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
       return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview()
        setConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubview() {
        [diaryImage, diaryTitle, diaryDate].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        diaryImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.size.equalTo(80)
        }
        
        diaryTitle.snp.makeConstraints { make in
            make.centerY.equalTo(self).offset(-10)
            make.leading.equalTo(self.snp.leading).offset(10)
        }
        
        diaryDate.snp.makeConstraints { make in
            make.top.equalTo(diaryTitle.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
        }
    }
}
