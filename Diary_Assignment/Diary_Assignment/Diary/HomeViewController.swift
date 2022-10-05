//
//  HomeViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/01.
//

import Foundation
import UIKit

import RealmSwift //Realm1. 라이브러리 추가

/*Realm데이터 화면 표시하기 순서
 1. 라이브러리 추가
 2. 저장경로 변수 생성
 3. 정렬된 Realm데이터 담을 Results<UserDiary> 변수 생성
 4. Realm데이터 정렬하여 tasks에 담기
 5. 데이터갱신하여 화면표시
 */

/*질문
 -. 커스텀셀이 아니면 따로 스위프트 파일 만들지 않고 tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")처럼 클래스파일이랑 identifier를 설정할수있는건지? 만약 셀파일에 객체만들려고하면 그때는 스위프트파일 생성해야하는지?
 */
class HomeViewController: UIViewController {
    
    let localRealm = try! Realm() //Realm2. 저장경로 변수 생성
    
    let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    //Realm3. 정렬된 Realm데이터 담을 Results타입 배열 생성(원본데이터를 사용하기보다 프로퍼티에 대입해서 사용하는게 좋음)
    var tasks: Results<UserDiary>! {
        didSet { //didSet사용하여 데이터 변경될때마다 reloadData일괄 처리
            tableView.reloadData()
            print("Tasks Changed")
        }
    }
    
    override func viewDidLoad() {
        print(#function)
        
        tableView.delegate = self
        tableView.dataSource = self
        //UITableViewCell.self의미: UITableViewCell가 가지고 있는 전체 값을 갖게된다.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
            let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
            let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
            
            navigationItem.leftBarButtonItems = [sortButton, filterButton]
        }
    }
    
    @objc func sortButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "regDate", ascending: false)
    }
    
    @objc func filterButtonClicked() {
        //CONTAINS[c]: 대소문자구분하지 않고 필터 가능
        //Realm문서-CRUD-Filter Data에서 다중조건 처리방법도 확인 가능
        tasks = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS '1'")
    }
    
    //네비게이션 컨트롤러의 동작할때 pop을 하면 스택에서 빠져나간 뷰 컨트롤러는 메모리에서 사라지기 때문에 화면전환시 viewDidLoad가 호출되지 않으므로 viewWillAppear에서 reloadData해줘야함
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
        
        print(#function) //구현이 안됐을땐 콘솔에서 코드가 실행되는지 안되는지 먼저 꼭 살피자.
        //tableView.reloadData() //Realm5. 데이터갱신하여 화면표시
    }
    
    @objc func plusButtonClicked() {
        let vc = DiaryViewController()
        //present, overCurrentPresent, overFullScreen은 viewWillAppear에서 실행안됨(view가 사라진걸로 인식하지 않기 때문)
        //vc.modalPresentationStyle = .fullScreen
        //present(vc, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchRealm() {
        //Realm4. Realm데이터 정렬하여 tasks에 담기
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tasks[indexPath.row].diaryTitle
        return cell
    }
    
    //반환값 작성형식 모를때는 우선 반환값 적어보자
    //UIContextualAction: 테이블셀 사용자가 스와이프할때 보여지는 액션
    //테이블뷰 높이에 따라서 제목설정해도 안보일 수 있음.
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            
            //Realm데이터 기준으로 즐겨찾기 이미지 업데이트(방식1이 상대적으로 효율적임. 데이터 한개바꼈는데 전체 데이터 가지고올 필요 없음)
            //방식1. 스와이프로 변경된 셀데이터만 reload, 방식2. 데이터가 변경됐으므로 다시 realm에서 데이터 가지고오기(didSet사용)
            try! self.localRealm.write {
                //하나의 레코드에서 특정컬럼 하나만 변경
                self.tasks[indexPath.row].favorite = !self.tasks[indexPath.row].favorite
                
                //하나의 레코드에서 컬럼 전체 변경
                //self.tasks.setValue(false, forKey: "favorite")
                
                //하나의 레코드에서 여러 컬럼 변경(변경하려는 컬럼 전에 구분용으로 pk를 넣어주어야 함)
                self.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectId, "diaryContent": "변경테스트", "diaryTitle": "제목임"], update: .modified)
                
                print("Realm Update Succeeded")
            }
            //self.fetchRealm() //방식1.
            print(self.tasks[indexPath.row].favorite)
        }
        
        
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image) //이미지,배경변경 하려면 프로퍼티접근해서 변경
        favorite.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    //trailing은 오른쪽부터 표시됨.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            print("favorite Button Clicked")
        }

        let example = UIContextualAction(style: .normal, title: "예시") { action, view, completionHandler in
            print("example Button Clicked")
        }
        return UISwipeActionsConfiguration(actions: [favorite, example])
    }
}



