//
//  HomeViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/01.
//

import Foundation
import UIKit

import FSCalendar
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
final class HomeViewController: BaseViewController {
    let repository = UserDiaryRepository()
    //let localRealm = try! Realm() //Realm2. 저장경로 변수 생성
    
    var mainView = HomeView()
    
    override func loadView() {
        self.view = mainView
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        //UITableViewCell.self의미: UITableViewCell가 가지고 있는 전체 값을 갖게된다.
        mainView.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        mainView.searchBar.delegate = self
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self

        
    }
    
    //Realm3. 정렬된 Realm데이터 담을 Results타입 배열 생성(원본데이터를 사용하기보다 프로퍼티에 대입해서 사용하는게 좋음)
    var tasks: Results<UserDiary>! {
        didSet { //didSet사용하여 데이터 변경될때마다 reloadData일괄 처리
            mainView.tableView.reloadData()
            print("Tasks Changed")
        }
    }
    
    override func viewDidLoad() {
        print(#function)
        configure()
        fetchRealm()
        fetchDocumentZipFile()
    }
    
    override func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton]
    }
 
    @objc func sortButtonClicked() {
        tasks = repository.fetchSort("diaryDate")
    }
    
    @objc func filterButtonClicked() {
        //CONTAINS[c]: 대소문자구분하지 않고 필터 가능
        //Realm문서-CRUD-Filter Data에서 다중조건 처리방법도 확인 가능
        tasks = repository.fetchFilter()
    }
    
    @objc func backupButtonClicked() {
        let vc = BackupViewController()
        present(vc, animated: true)
    }
    
    //네비게이션 컨트롤러의 동작할때 pop을 하면 스택에서 빠져나간 뷰 컨트롤러는 메모리에서 사라지기 때문에 화면전환시 viewDidLoad가 호출되지 않으므로 viewWillAppear에서 reloadData해줘야함
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.calendar.reloadData() //캘린더도 컬렉션뷰이므로 데이터변경 후 화면갱신 해줘야함
        mainView.tableView.reloadData()
        print(#function) //구현이 안됐을땐 콘솔에서 코드가 실행되는지 안되는지 먼저 꼭 살피자.
    }
    
    @objc func plusButtonClicked() {
        let vc = DiaryViewController()
        //present, overCurrentPresent, overFullScreen은 viewWillAppear에서 실행안됨(view가 사라진걸로 인식하지 않기 때문)
        //vc.modalPresentationStyle = .fullScreen
        //present(vc, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
        //transitionViewController2(vc, transitionStyle: .presentFullNavigation) //화면전환 메서드 사용
    }
    
    func fetchRealm() {
        //Realm4. Realm데이터 정렬하여 tasks에 담기
        tasks = repository.fetch()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: tasks[indexPath.row].diaryDate)
        
        cell.diaryImage.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg") //도큐먼트에 저장된 다이어리사진 화면 표시
        cell.diaryTitle.text = tasks[indexPath.row].diaryTitle
        cell.diaryDate.text = date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DiaryViewController() //데이터 저장된 곳으로 화면이동
        present(vc, animated: true)
        //self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //반환값 작성형식 모를때는 우선 반환값 적어보자
    //UIContextualAction: 테이블셀 사용자가 스와이프할때 보여지는 액션
    //테이블뷰 높이에 따라서 제목설정해도 안보일 수 있음.
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            
            //Realm데이터 기준으로 즐겨찾기 이미지 업데이트(방식1이 상대적으로 효율적임. 데이터 한개바꼈는데 전체 데이터 가지고올 필요 없음)
            //방식1. 스와이프로 변경된 셀데이터만 reload, 방식2. 데이터가 변경됐으므로 다시 realm에서 데이터 가지고오기(didSet사용)
            self.repository.updateFavorite(item: self.tasks[indexPath.row])
                print("Realm Update Succeeded")
            }
        
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image) //이미지,배경변경 하려면 프로퍼티접근해서 변경
        favorite.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [favorite]) //trailing은 오른쪽부터 표시됨.
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            self.repository.deleteItem(item: self.tasks[indexPath.row])
            
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tasks = repository.localRealm.objects(UserDiary.self).filter("diaryContents CONTAINS '\(searchBar.text!)'")
    }
   
    //취소버튼 생성
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    //취소버튼 클릭액션
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = "" //검색어 삭제
        tasks = repository.localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: true) //화면 갱신(didSet)
    }
}

extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
    //.(점)으로 이벤트 갯수 표시
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count //realm레코드가 추가되면서 데이터갯수가 바뀌므로 캘린더 컬렉션뷰도 화면갱신해줘야함.
    }
    
    //달력 날짜 대신 문자 입력
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "새싹"
//    }
    
    //날짜 밑에 이미지 표시
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let image = UIImage(systemName: "star.fill")
        return mainView.dateFormatter.string(from: date) == "220907" ? image : nil
    }
    
    //조건설정해서 소제목표시 가능
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return mainView.dateFormatter.string(from: date) == "220907" ? "오프라인모임" : nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //repository에서 realm테이블 필터링해서 선택한 날짜에 맞는 일기내용만 표시
        tasks = repository.fetchDate(date: date)
    }
    
}
