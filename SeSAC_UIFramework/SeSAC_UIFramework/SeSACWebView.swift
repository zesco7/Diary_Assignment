//
//  SeSACWebView.swift
//  SeSAC_UIFramework
//
//  Created by Mac Pro 15 on 2022/09/25.
//

import UIKit
import WebKit

//화면전환 스타일 설정(present, push)
open class OpenWebView {
    public enum TransitionStyle {
        case present
        case push
    }
    
    public static func presentWebViewController(_ viewController: UIViewController, url: String, transitionStyle: TransitionStyle) {

        let vc = WebViewController()
        vc.url = url
        //vc.webView = nil //WebViewController에서 webView는 private여서 접근할 수 없다.(접근해서 이상한 값을 줄 수 있기 때문에 접근자체를 차단함)
        switch transitionStyle {
        case .present:
            viewController.present(vc, animated: true)
        case .push:
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


class WebViewController: UIViewController {
    
    private var webView: WKWebView!
    var url: String = "https://www.apple.com"
    
    override func loadView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
