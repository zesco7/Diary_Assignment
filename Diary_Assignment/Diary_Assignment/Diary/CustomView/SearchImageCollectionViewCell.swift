//
//  SearchImageCollectionViewCell.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/29.
//

import UIKit
import SnapKit

/*컬렉션뷰셀 순서
 1.컬렉션뷰셀에 표시할 객체 만들기(photoImageView)
 2.컬렉션뷰셀에 객체 추가하기(addSubview)
 3.컬렉션뷰셀에 표시할 객체 레이아웃 설정하기(snapkit사용)
 4.공통UI있으면 코드구현해서 적용하기
 */

class SearchImageCollectionViewCell: UICollectionViewCell {
    static var identifier = "SearchImageCollectionViewCell"
    
    var photoImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview()
        setConstraint()
        setupImageViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //뷰계층구조상 UICollectionViewCell에 contentView가 있고 그 위에 객체를 추가하는 것이기 때문에 addSubview가 아닌 contentView.addSubview
    func addSubview() {
        self.contentView.addSubview(photoImage)
    }
    
    func setConstraint() {
        photoImage.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.size.equalTo(self)
        }
    }
    
    func setupImageViewUI() {
        
    }
    
    func showSelectionBox() {
        photoImage.layer.borderWidth = 5
        photoImage.layer.borderColor = UIColor.red.cgColor
    }
    
    func hideSelectionBox() {
        photoImage.layer.borderWidth = 0
        photoImage.layer.borderColor = UIColor.clear.cgColor
    }
}
