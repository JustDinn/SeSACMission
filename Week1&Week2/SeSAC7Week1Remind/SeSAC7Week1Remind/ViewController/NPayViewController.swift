//
//  NPayViewController.swift
//  SeSAC7Week1Remind
//
//  Created by HyoTaek on 7/7/25.
//

import UIKit

class NPayViewController: UIViewController {

    @IBOutlet var xButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var modalStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        makeStackView()
        makeButtonUI(button: xButton, image: "xmark")
        makeImageView(imageView: imageView, image: "lock")
        makeLabelUI(label: titleLabel, title: """
                                              한 번만 인증하고
                                              비밀번호 없이 결제하세요   
                                              """)
        makeButtonUI(button: checkButton, image: "checkmark", title: "바로 결제 사용하기", titleColor: .black)
        makeButtonUI(button: confirmButton, title: "확인", backgroundColor: .systemGreen, titleColor: .black)
    }
    
    func makeButtonUI(button: UIButton, image: String? = nil, title: String? = nil, backgroundColor: UIColor? = nil, titleColor: UIColor? = nil, cornerRadius: CGFloat? = nil) {
        var config = UIButton.Configuration.plain()
        
        if let title = title {
            config.title = title
        }
        if let imageName = image {
            config.image = UIImage(systemName: imageName)
        }
        if let backgroundColor = backgroundColor {
            config.background.backgroundColor = backgroundColor
        }
        config.baseForegroundColor = .black
        config.imagePlacement = .leading
        config.imagePadding = 10.0
        
        button.configuration = config
    }
    
    func makeImageView(imageView: UIImageView, image: String) {
        imageView.image = UIImage(systemName: image)
        imageView.contentMode = .scaleAspectFill
    }
    
    func makeLabelUI(label: UILabel, title: String) {
        label.text = title
        label.textAlignment = .center
        label.numberOfLines = 0
    }
    
    func makeStackView() {
        modalStackView.backgroundColor = .white
        modalStackView.layer.cornerRadius = 20
    }
}
