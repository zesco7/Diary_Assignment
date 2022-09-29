//
//  SearchImageView.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/29.
//

import Foundation
import UIKit

class SearchImageView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력하세요"
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout) //컬렉션뷰 생성할때 레이아웃으로 초기화 시켜줘야 함.
        view.backgroundColor = .yellow
        view.collectionViewLayout = layout
        return view
    }()
    
    let collectionViewCell: UICollectionViewCell = {
       let view = UICollectionViewCell()
        view.backgroundColor = .red
        return view
    }()
    
    override func configureUI() {
        [searchBar, collectionView, collectionViewCell].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(self)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.width.equalTo(self)
            make.height.equalTo(self)
        }
    }
}
