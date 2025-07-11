//
//  NewHotViewController.swift
//  SesacWeek1
//
//  Created by HyoTaek on 7/2/25.
//

import UIKit

class NewHotViewController: UIViewController {

    // MARK: - Properties
    
    private let keywordText = [
        "이런! 찾으시는 작품이 없습니다.",
        "인기 콘텐츠",
        "TOP 10"
    ]
    
    // MARK: - Components
    
    @IBOutlet var expectedReleaseButton: UIButton!
    @IBOutlet var popularContentButton: UIButton!
    @IBOutlet var top10Button: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButtonColor()
        makeButton(button: expectedReleaseButton, tag: 0)
        makeButton(button: popularContentButton, tag: 1)
        makeButton(button: top10Button, tag: 2)
    }
    
    // MARK: Make Button
    
    private func makeButton(button: UIButton, tag: Int) {
        button.tag = tag
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
    }
    
    // MARK: - Action
    
    // Keyword Tap
    @IBAction func didTapKeyword(_ sender: UIButton) {
        titleLabel.text = keywordText[sender.tag]
        updateButtonColor(buttonTag: sender.tag)
    }
    
    // Init Button Color
    private func initButtonColor() {
        expectedReleaseButton.backgroundColor = .black
        expectedReleaseButton.tintColor = .black
        popularContentButton.backgroundColor = .black
        popularContentButton.tintColor = .black
        top10Button.backgroundColor = .black
        top10Button.tintColor = .black
    }
    
    // Update Button BackgroundColor
    private func updateButtonColor(buttonTag: Int) {
        initButtonColor()
        
        switch buttonTag {
        case 0:
            expectedReleaseButton.backgroundColor = .red
            expectedReleaseButton.tintColor = .red
            
        case 1:
            popularContentButton.backgroundColor = .red
            popularContentButton.tintColor = .red
            
        case 2:
            top10Button.backgroundColor = .red
            top10Button.tintColor = .red
            
        default:
            print("잘못된 버튼 접근")
        }
    }
}
