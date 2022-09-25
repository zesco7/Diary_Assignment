//
//  SeSACReusableProtocol.swift
//  SeSAC_UIFramework
//
//  Created by Mac Pro 15 on 2022/09/25.
//

import UIKit

public protocol ReusableViewProtocol { //open은 상속때문에 클래스만 사용가능
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
