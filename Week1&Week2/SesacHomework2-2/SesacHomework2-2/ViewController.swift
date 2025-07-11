//
//  ViewController.swift
//  SesacHomework2-2
//
//  Created by HyoTaek on 7/2/25.
//

import UIKit

class ViewController: UIViewController {
    let imageSize = CGSize(width: 60, height: 60)
    var buttonCounting = [Int](repeating: 0, count: 9)
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        var buttonConfig = UIButton.Configuration.plain()
        
        buttonConfig.title = ""
        buttonConfig.imagePlacement = .top
        
        button1.tag = 0
        button1.setImage(UIImage(named: "mono_slime1")?.resize(to: imageSize), for: .normal)
        
        button2.tag = 1
        button2.setImage(UIImage(named: "mono_slime2")?.resize(to: imageSize), for: .normal)
        
        button3.tag = 2
        button3.setImage(UIImage(named: "mono_slime3")?.resize(to: imageSize), for: .normal)
        
        button4.tag = 3
        button4.setImage(UIImage(named: "mono_slime4")?.resize(to: imageSize), for: .normal)
        
        button5.tag = 4
        button5.setImage(UIImage(named: "mono_slime5")?.resize(to: imageSize), for: .normal)
        
        button6.tag = 5
        button6.setImage(UIImage(named: "mono_slime6")?.resize(to: imageSize), for: .normal)
        
        button7.tag = 6
        button7.setImage(UIImage(named: "mono_slime7")?.resize(to: imageSize), for: .normal)
        
        button8.tag = 7
        button8.setImage(UIImage(named: "mono_slime8")?.resize(to: imageSize), for: .normal)
        
        button9.tag = 8
        button9.setImage(UIImage(named: "mono_slime9")?.resize(to: imageSize), for: .normal)
        
        button1.configuration = buttonConfig
        button2.configuration = buttonConfig
        button3.configuration = buttonConfig
        button4.configuration = buttonConfig
        button5.configuration = buttonConfig
        button6.configuration = buttonConfig
        button7.configuration = buttonConfig
        button8.configuration = buttonConfig
        button9.configuration = buttonConfig
    }
    
    @IBAction func didTapButtonRandom(_ sender: UIButton) {
        let randomNumber = Int.random(in: 0..<10)
        
        sender.setTitle("\(randomNumber)", for: .normal)
        sender.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func didTapButtonCounting(_ sender: UIButton) {
//        print("sender: \(sender.tag)")
        buttonCounting[sender.tag] += 1
        
        sender.setTitle("\(buttonCounting[sender.tag])", for: .normal)
        sender.setTitleColor(.black, for: .normal)
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
