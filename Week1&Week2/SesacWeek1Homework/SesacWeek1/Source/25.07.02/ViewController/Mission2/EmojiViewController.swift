//
//  EmojiViewController.swift
//  SesacWeek1
//
//  Created by HyoTaek on 7/3/25.
//

import UIKit

class EmojiViewController: UIViewController {

    // MARK: - Properties
    
    private let emojiImage = [
        "mono_slime1",
        "mono_slime2",
        "mono_slime3",
        "mono_slime4",
        "mono_slime5",
        "mono_slime6",
        "mono_slime7",
        "mono_slime8",
        "mono_slime9"
    ]
    
    private let emojiText: [Int: String] = [
        0: "행복해",
        1: "사랑해",
        2: "좋아해",
        3: "당황해",
        4: "속상해",
        5: "우울해",
        6: "심심해",
        7: "행복해",
        8: "행복해"
    ]
    
    private var buttonCounting = [Int](repeating: 0, count: 9)
    
    // MARK: - Component
    
    @IBOutlet var emojiButtons: [UIButton]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeButton()
    }
    
    // MARK: - Make Button
    
    private func makeButton() {
        for i in 0..<emojiImage.count {
            let button = emojiButtons[i]
            let buttonImage = emojiImage[i]
            var config = UIButton.Configuration.plain()
            
            config.image = UIImage(named: buttonImage)?.resize(to: CGSize(width: 81, height: 81))
            config.imagePlacement = .top
            config.title = emojiText[i]
            
            button.configuration = config
            button.tag = i
        }
    }
    
    // MARK: - Action
    
    // Random Number
    @IBAction func didTapEmojiButtonRandom(_ sender: UIButton) {
        let randomNumber = Int.random(in: 0..<10)
        guard let emojiTitle = emojiText[sender.tag] else {
            print("이모지 텍스트 찾을 수 없음")
            return
        }
        
        sender.configuration?.title = "\(emojiTitle) \(randomNumber)"
    }
    
    // Count Number
    @IBAction func didTapEmojiButtonCount(_ sender: UIButton) {
        guard let emojiTitle = emojiText[sender.tag] else {
            print("이모지 텍스트 찾을 수 없음")
            return
        }
        
        buttonCounting[sender.tag] += 1
        sender.configuration?.title = "\(emojiTitle) \(buttonCounting[sender.tag])"
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
