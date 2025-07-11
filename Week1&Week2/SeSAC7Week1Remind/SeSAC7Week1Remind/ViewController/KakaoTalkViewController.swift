//
//  KakaoTalkViewController.swift
//  SeSAC7Week1Remind
//
//  Created by HyoTaek on 7/6/25.
//

import UIKit

class KakaoTalkViewController: UIViewController {

    @IBOutlet var topStackView: UIStackView!
    @IBOutlet var xButton: UIButton!
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var bottomButton1: UIButton!
    @IBOutlet var bottomButton2: UIButton!
    @IBOutlet var bottomButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeButtonUI(button: xButton, image: "xmark")
        makeStackView(stackView: topStackView, spacing: 30, distribution: .equalSpacing)
        makeButtonUI(button: firstButton, image: "heart.circle")
        makeButtonUI(button: secondButton, image: "cube.box")
        makeButtonUI(button: thirdButton, image: "gearshape")
        makeImageView(imageView: profileImageView, image: "person.circle.fill")
        makeLabelUI(label: nameLabel, title: "권효택")
        makeButtonUI(button: bottomButton1, image: "bubble", title: "나와의 채팅")
        makeButtonUI(button: bottomButton2, image: "pencil", title: "프로필 편집")
        makeButtonUI(button: bottomButton3, image: "scribble", title: "카카오 스토리")
    }
    
    func makeButtonUI(button: UIButton, image: String, title: String? = nil) {
        var config = UIButton.Configuration.plain()
        
        config.image = UIImage(systemName: image)
        config.title = title
        config.imagePlacement = .top
        config.imagePadding = 6.0
        
        button.configuration = config
    }
    
    func makeStackView(stackView: UIStackView, spacing: CGFloat, distribution: UIStackView.Distribution) {
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.alignment = .center
    }
    
    func makeImageView(imageView: UIImageView, image: String) {
        imageView.image = UIImage(systemName: image)
        imageView.contentMode = .scaleAspectFill
    }
    
    func makeLabelUI(label: UILabel, title: String) {
        label.text = title
    }
}
