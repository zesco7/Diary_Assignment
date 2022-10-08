//
//  BackupViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/10/08.
//

import UIKit

class BackupViewController: UIViewController {

    var mainView = BackupView()
    override func loadView() {
        self.view = mainView
        mainView.backgroundColor = .lightGray
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(BackupTableViewCell.self, forCellReuseIdentifier: "BackupTableViewCell")
        mainView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


}

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BackupTableViewCell", for: indexPath) as? BackupTableViewCell else { return UITableViewCell() }
        cell.backupDataLabel.text = "백업 테스트"
        return cell
    }
}
