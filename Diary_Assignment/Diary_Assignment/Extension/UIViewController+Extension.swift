//
//  UIViewController+Extension.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/27.
//

import UIKit

//제네릭을 사용하여 인자에 조건을 설정한다.(UIViewController타입만 불러올수있도록)
extension UIViewController {
    func transitionViewController<T: UIViewController>(storyboard: String, viewController controller: T) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: controller) ) as? T else { return } //타입캐스팅 성공하면 vc값 반환되고 실패하면 nil반환
        self.present(vc, animated: true)
        
    }
}
