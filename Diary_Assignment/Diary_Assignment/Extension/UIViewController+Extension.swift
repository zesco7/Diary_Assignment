//
//  UIViewController+Extension.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/27.
//

import UIKit

//제네릭을 사용하여 인자에 조건을 설정한다.(UIViewController타입만 불러올수있도록)
extension UIViewController {
    enum TransitionStyle {
        case present //네비게이션 없이 present
        case presentNavigation //네비게이션 임베드 present
        case presentFullNavigation //네비게이션 풀스크린
        case push
    }
    
    func transitionViewController<T: UIViewController>(storyboard: String, viewController controller: T) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: controller) ) as? T else { return } //타입캐스팅 성공하면 vc값 반환되고 실패하면 nil반환
        self.present(vc, animated: true)
    }
    
    //열거형 사용하여 화면전환 메서드 생성
    func transitionViewController2<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        switch transitionStyle {
        case .present:
            //self.present(T(), animated: true) //새로운 인스턴스 T()대신 전달받은 뷰컨트롤러 viewController를 사용해야함.
            self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
