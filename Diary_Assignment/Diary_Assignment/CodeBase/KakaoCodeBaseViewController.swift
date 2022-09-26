//
//  KakaoCodeBaseViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/26.
//


/*질문
 -. 버튼사이즈크기대로 버튼이미지 사이즈도 같이 키우는 코드 뭔지? ex.오른쪽상단 회색박스크기 키우면 회색박스크기만 늘어나고 안에 이미지는 그대로
 -. 버튼타이틀을 버튼이미지 밑으로 내릴수 있는 코드 뭔지? sb처럼 placement로 찾아봐도 나오지 않음...
 
 */
import UIKit
import SnapKit

class KakaoCodeBaseViewController: UIViewController {

    
    let closeButton : UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .white
        
        return view
    }()
    
    let heartButton : UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        view.tintColor = .white

        
        return view
    }()
    
    let checkerboardButton : UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "checkerboard.rectangle"), for: .normal)
        view.tintColor = .white
        
        return view
    }()
    
    let settingButton : UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "gearshape"), for: .normal)
        view.tintColor = .white
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    let profileImage : UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    let profileName : UILabel = {
        let view = UILabel()
        view.text = "이름을 입력하세요"
        view.textColor = .white
        view.textAlignment = .center

        return view
    }()

    let profileIntroduction : UILabel = {
        let view = UILabel()
        view.text = "자기소개를 입력하세요"
        view.textColor = .white
        view.textAlignment = .center

        return view
    }()

    let divisionLine : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.2

        return view
    }()

    let chatToMeButton : UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "person.crop.circle.badge"), for: .normal)
        view.setTitle("나와의 채팅", for: .normal)
        view.tintColor = .white
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.titleLabel?.textAlignment = .center
        
        return view
    }()

    let profileEditingButton : UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "pencil"), for: .normal)
        view.setTitle("프로필 편집", for: .normal)
        view.tintColor = .white
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.titleLabel?.textAlignment = .center

        return view
    }()

    let kakaoStroyButton : UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "music.note"), for: .normal)
        view.setTitle("카카오 스토리", for: .normal)
        view.tintColor = .white
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.titleLabel?.textAlignment = .center

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [closeButton, heartButton, checkerboardButton, settingButton, profileImage, profileName, profileIntroduction, divisionLine, chatToMeButton, profileEditingButton, kakaoStroyButton].forEach {
        view.addSubview($0)
        }
        
        closeButton.snp.makeConstraints { make in
            make.topMargin.equalTo(20)
            make.leadingMargin.equalTo(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        heartButton.snp.makeConstraints { make in
            make.topMargin.equalTo(20)
            make.trailingMargin.equalTo(checkerboardButton.snp.leading).offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        checkerboardButton.snp.makeConstraints { make in
            make.topMargin.equalTo(20)
            make.trailingMargin.equalTo(settingButton.snp.leading).offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        settingButton.snp.makeConstraints { make in
            make.topMargin.equalTo(20)
            make.trailingMargin.equalTo(-10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        profileImage.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(1.25)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        profileName.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(profileImage.snp.bottom).offset(10)
            make.leadingMargin.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(100)
            make.trailingMargin.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(-50)
            make.height.equalTo(20)
        }
        
        profileIntroduction.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(profileName.snp.bottom).offset(10)
            make.leadingMargin.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(50)
            make.trailingMargin.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(-50)
            make.height.equalTo(20)
        }
        
        divisionLine.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(profileIntroduction.snp.bottom).offset(20)
            make.width.equalTo(view)
            make.height.equalTo(1)
        }
        
        chatToMeButton.snp.makeConstraints { make in
            make.top.equalTo(divisionLine.snp.bottom)
            make.trailing.equalTo(profileEditingButton.snp.leading).offset(-40)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        profileEditingButton.snp.makeConstraints { make in
            make.top.equalTo(divisionLine.snp.bottom)
            make.centerX.equalTo(view)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        kakaoStroyButton.snp.makeConstraints { make in
            make.top.equalTo(divisionLine.snp.bottom)
            make.leading.equalTo(profileEditingButton.snp.trailing).offset(40)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
    }
}
