//
//  ViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/24.
//

import UIKit
import SeSAC_UIFramework
import SnapKit

class ViewController: UIViewController {
    
    let nameButton: UIButton = {
        let view = UIButton()
        view.setTitle("닉네임", for: .normal)
        view.backgroundColor = .black
        view.tintColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        nameButton.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
    
    }
    
    //ProfileViewController가 스토리보드에 연결된 상태라면(+아웃렛도 있다면) 스토리보드까지 가지고와줘야 화면에 표시할 수 있다. 단순히 뷰컨트롤러만 가져온다고 화면에 보이지 않음
    @objc func nameButtonClicked() {
        let vc = ProfileViewController()
        vc.saveButtonActionHandler = { //값전달처럼 saveButtonActionHandler을 ProfileViewController로 넘겨주는 구조
            self.nameButton.setTitle(vc.nameTextField.text, for: .normal)
        }
        
        present(vc, animated: true)
    }
    
    func configure() {
        view.addSubview(nameButton)
        
        nameButton.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalTo(view)
        }
    }
    
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = KakaoCodeBaseViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
        testOpen()
//        showSeSACAlert(title: "테스트얼럿", message: "테스트메시지", buttonTitle: "변경") { _ in
//            self.view.backgroundColor = .lightGray
//        }
        
        let image = UIImage(systemName: "star.fill")!
        let shareURL = "https://www.apple.com"
        let text = "WWDC What's New!!!"
        //sesacActivityViewController(shareImage: image, shareURL: shareURL, shareText: text)
        
        //let web = OpenWebView() // open인데도 왜 접근이 안되는지?
        OpenWebView.presentWebViewController(self, url: "https://www.apple.com", transitionStyle: .present)
    }
     */
}

