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
        //Realm4. Realm데이터 정렬하여 tasks에 담기
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: true)
        
        print(#function) //구현이 안됐을땐 콘솔에서 코드가 실행되는지 안되는지 먼저 꼭 살피자.
        //tableView.reloadData() //Realm5. 데이터갱신하여 화면표시
    }
    
    @objc func plusButtonClicked() {
        let vc = DiaryViewController()
        //present, overCurrentPresent, overFullScreen은 viewWillAppear에서 실행안됨(view가 사라진걸로 인식하지 않기 때문)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        //self.navigationController?.pushViewController(vc, animated: true)
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
}
