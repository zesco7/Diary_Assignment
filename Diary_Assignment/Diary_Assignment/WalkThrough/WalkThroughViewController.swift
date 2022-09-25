//
//  WalkThroughViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/25.
//

import UIKit

/*페이지뷰 순서
 1. 배열 형태로 뷰컨트롤러 추가: 페이지로 표시할 뷰컨트롤러를 만드는 과정
 2. 빈배열에 뷰컨트롤러 넣기: viewDidLoad에 넣는 대신 메서드로 만들어 처리
 3,4. 프로토콜 연결, 생성
 5. 시작화면 설정: 화면이 여러개이므로 처음에 보여줄 화면을 정해줘야 함
 6. 페이지 넘기는 기능: 배열형태라고해서 배열순서대로 화면을 보여주는게 아니기 때문에 현재 보이는 화면이 몇번째인지 인덱스 정보를 받아서 표시순서를 정해줘야 함.
 7. 페이지 컨트롤 추가(페이지 구분 + 순서표시): 현재 화면이 몇번째 화면인지 사용자가 구분할 수 있도록 보여주는 기능
 */

class WalkThroughViewController: UIPageViewController {

    //1.뷰컨트롤러타입의 빈배열 만들기: 페이지로 표시할 뷰컨트롤러를 만드는 과정
    var pageViewControllerList: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray //페이지컨트롤 표시되는 부분 색상은 뷰의 기본색 때문에 검정색으로 표시되는 것이므로 뷰 배경색 바꾸면 색변경 가능
        createPageViewController()
        configurePageViewController()
    }
    
    //2.빈배열에 뷰컨트롤러 넣기: viewDidLoad에 넣는 대신 메서드로 만들어 처리
    func createPageViewController() {
        let sb = UIStoryboard(name: "WalkThrough", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: FiirstViewController.reuseIdentifier) as! FiirstViewController
        let vc2 = sb.instantiateViewController(withIdentifier: SecondViewController.reuseIdentifier) as! SecondViewController
        let vc3 = sb.instantiateViewController(withIdentifier: ThirdViewController.reuseIdentifier) as! ThirdViewController
        
        pageViewControllerList = [vc1, vc2, vc3]
    }
    
    //3.프로토콜 연결
    func configurePageViewController() {
        delegate = self
        dataSource = self
        
        //5.시작화면 설정: 화면이 여러개이므로 처음에 보여줄 화면을 정해줘야 함
        //pageViewControllerList.first는 pageViewControllerList[0]과 같은 의미
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true) //화면에 뷰컨트롤러 보여줌
    }
}

//4.프로토콜 생성
extension WalkThroughViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    //6.페이지 넘기는 기능: 배열형태라고해서 배열순서대로 화면을 보여주는게 아니기 때문에 현재 보이는 화면이 몇번째인지 인덱스 정보를 받아서 표시순서를 정해줘야 함.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil } //화면인덱스 확인 코드
        let previousIndex = viewControllerIndex - 1
        print(pageViewControllerList.firstIndex(of: viewController))
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    //7.페이지 컨트롤 추가(페이지 구분 + 순서표시): 현재 화면이 몇번째 화면인지 사용자가 구분할 수 있도록 보여주는 기능
    //페이지 구분
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    //페이지 순서 표시
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: first) else { return 0 } //첫번째 페이지만 인덱스 확인되면 나머지는 자동으로 설정됨
        return index
    }
}
