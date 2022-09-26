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
    
    @IBOutlet weak var starImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorialLabel.numberOfLines = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 20)
        tutorialLabel.text = """
        일기 씁시다!
        잘 써봅시다!
        """
        tutorialLabel.alpha = 0.5
        tutorialLabel.backgroundColor = .red
        blackView.backgroundColor = .yellow
        blackView.alpha = 0
        
        starImageView.image = UIImage(systemName: "star.fill")
        
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
            self.tutorialLabel.backgroundColor = .green
        } completion: { _ in
            self.animateblackView()
            print("completion")
            
        }
        
        animateImageView()
    }
    
    //색상변경 메서드
    func animateblackView() {
        UIView.animate(withDuration: 3) {
            //self.blackView.frame.size.width += 250
            self.blackView.transform = CGAffineTransform(scaleX: 4, y: 1)
            self.blackView.alpha = 1
        } completion: { _ in
            print(#function)
        }
    }
    
    //형태변경 메서드: 가로세로 사이즈 조정, 반복 가능
    func animateImageView() {
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse] ) {
            self.starImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { _ in
            print(#function)
        }

    }
    
}
