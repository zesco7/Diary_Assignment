//
//  FiirstViewController.swift
//  Diary_Assignment
//
//  Created by Mac Pro 15 on 2022/09/25.
//

import UIKit

class FiirstViewController: UIViewController {
    @IBOutlet weak var tutorialLabel: UILabel!
    
    @IBOutlet var blackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorialLabel.numberOfLines = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 20)
        tutorialLabel.text = """
        일기 씁시다!
        잘 써봅시다!
        """
        tutorialLabel.alpha = 0
        blackView.backgroundColor = .yellow
        blackView.alpha = 0
        
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
        } completion: { _ in
            self.animateblackView()
            print("completion")
            
        }
    }
    
    func animateblackView() {
        UIView.animate(withDuration: 3) {
            self.blackView.frame.size.width += 250
            self.blackView.alpha = 1
        } completion: { _ in
            print(#function)
        }

        
    }
    
}
