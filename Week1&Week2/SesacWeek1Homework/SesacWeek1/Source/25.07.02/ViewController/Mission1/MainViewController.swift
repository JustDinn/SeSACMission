//
//  250702ViewController.swift
//  SesacWeek1
//
//  Created by HyoTaek on 7/2/25.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    
    private let movieList = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "극한직업",
        "도둑들",
        "명량",
        "베테랑",
        "부산행",
        "신과함께인과연",
        "신과함께죄와벌",
        "아바타",
        "알라딘",
        "암살",
        "어벤져스엔드게임",
        "왕의남자",
        "태극기휘날리며",
        "택시운전사",
        "해운대"
    ]
    
    // MARK: - Components
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    
    @IBOutlet var firstTop100: UILabel!
    @IBOutlet var firstEpisode: UILabel!
    @IBOutlet var firstPlay: UILabel!
    
    @IBOutlet var secondeTop100: UILabel!
    @IBOutlet var secondeEpisode: UILabel!
    @IBOutlet var secondePlay: UILabel!
    
    @IBOutlet var thirdTop100: UILabel!
    @IBOutlet var thirdEpisode: UILabel!
    @IBOutlet var thirdPlay: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setImageViewUI(imageView: mainImageView)
        setImageViewUI(imageView: firstImageView)
        setImageViewUI(imageView: secondImageView)
        setImageViewUI(imageView: thirdImageView)
        setLabelUI()
    }
    
    // MARK: - UI Setting
    
    // Set ImageView UI
    private func setImageViewUI(imageView: UIImageView) {
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.layer.borderWidth = 2
    }
    
    // Set Label UI
    private func setLabelUI() {
        firstTop100.textColor = .white
        firstEpisode.textColor = .white
        firstPlay.textColor = .white
        secondeTop100.textColor = .white
        secondeEpisode.textColor = .white
        secondePlay.textColor = .white
        thirdTop100.textColor = .white
        thirdEpisode.textColor = .white
        thirdPlay.textColor = .white
    }
    
    // MARK: - Action
    
    // Did Tap PlayButton
    @IBAction func didTapPlayButton(_ sender: UIButton) {
        // TODO: 영화 중복 방지 로직 추가
        let randomNumber1 = Int.random(in: 0..<movieList.count)
        let randomNumber2 = Int.random(in: 0..<movieList.count)
        let randomNumber3 = Int.random(in: 0..<movieList.count)
        let randomNumber4 = Int.random(in: 0..<movieList.count)
        
        mainImageView.image = UIImage(named: movieList[randomNumber1])
        firstImageView.image = UIImage(named: movieList[randomNumber2])
        secondImageView.image = UIImage(named: movieList[randomNumber3])
        thirdImageView.image = UIImage(named: movieList[randomNumber4])
        
        firstTop100.isHidden = Bool.random()
        firstEpisode.isHidden = Bool.random()
        firstPlay.isHidden = Bool.random()
        
        secondeTop100.isHidden = Bool.random()
        secondePlay.isHidden = Bool.random()
        secondeEpisode.isHidden = Bool.random()
        
        thirdTop100.isHidden = Bool.random()
        thirdEpisode.isHidden = Bool.random()
        thirdPlay.isHidden = Bool.random()
    }
}
