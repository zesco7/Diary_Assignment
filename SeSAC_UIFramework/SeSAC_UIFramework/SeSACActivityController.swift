//
//  SeSACActivityController.swift
//  SeSAC_UIFramework
//
//  Created by Mac Pro 15 on 2022/09/25.
//

import UIKit //에어드랍 할때 뜨는 화면

extension UIViewController {
    
    public func sesacActivityViewController(shareImage: UIImage, shareURL: String, shareText: String) {
        let viewController = UIActivityViewController(activityItems: [shareImage, shareURL, shareText], applicationActivities: nil)
        viewController.excludedActivityTypes = [.mail, .assignToContact] //메뉴에서 항목 제거
        self.present(viewController, animated: true)
    }
    
}
