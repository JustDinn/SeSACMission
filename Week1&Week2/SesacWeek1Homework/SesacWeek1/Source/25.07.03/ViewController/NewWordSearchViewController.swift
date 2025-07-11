//
//  NewWordSearchViewController.swift
//  SesacWeek1Homework
//
//  Created by HyoTaek on 7/3/25.
//

import UIKit

final class NewWordSearchViewController: UIViewController {

    // MARK: - Properties
    
    private var newWordList: [String: String] = [
        "삼귀다": "연애를 시작하기 전 썸 단계",
        "가즈아": "주식이나 코인이 떡상하길 바라며 외치는 단어",
        "추구미": "추구하는 미적 스타일",
        "슬세권": "슬리퍼와 역세권을 합친 단어로 슬리퍼를 신고 다닐 수 있는 편의시설이 가까운 주거 지역",
        "JMT": "존맛탱의 영어표현으로 엄청 맛있는 음식을 표현하는 단어",
        "별다줄": "별걸 다 줄인다",
        "소확행": "소소하지만 확실한 행복의 준말",
        "네카라쿠배당토": "네이버 카카오 라인 쿠팡 배달의민족 당근 토스 레츠고",
        "점메추": "점심 메뉴 추천",
        "느좋": "느낌 좋다",
        "핑프": "핑크 프린세스의 준말로 어떤 일에 노력을 하지 않고 결과만 바라는 사람을 일컫는 말",
        "사바사": "사람 바이 사람의 준말로 사람마다 다르다는 뜻"
    ]
    private var recomendedWords: [String] = []
    private var searchedHistoryWords = [String](repeating: "", count: 3)
    
    // MARK: - Components
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchResultLabel: UILabel!
    @IBOutlet var resultImageView: UIImageView!
    
    @IBOutlet var recomendWordLabel: UILabel!
    @IBOutlet var searchHistoryLabel: UILabel!
    
    @IBOutlet var recomendWordButtons: [UIButton]!
    @IBOutlet var historyButtons: [UIButton]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recomendedWords = Array(newWordList.keys).shuffled()
        setSearchTextField()
        setSearchButton()
        makeLabelUI(label: recomendWordLabel, title: "추천 검색어", textColor: .black)
        makeLabelUI(label: searchHistoryLabel, title: "검색 기록", textColor: .black)
        setResultLabel()
        setResultImageView()
        setRandomRecomendButton()
        setHistoryButton()
    }
    
    // MARK: - Setting
    
    // Set searchTextField
    private func setSearchTextField() {
        searchTextField.placeholder = "신조어를 검색해보세요"
        searchTextField.layer.borderColor = UIColor.black.cgColor
        searchTextField.layer.borderWidth = 1.5
        searchTextField.returnKeyType = .done
    }
    
    // Set searchButton
    private func setSearchButton() {
        var config = UIButton.Configuration.filled()
        
        config.background.backgroundColor = .black
        config.image = UIImage(systemName: "magnifyingglass")
        
        searchButton.configuration = config
    }
    
    // Set ResultLabel
    private func setResultLabel() {
        searchResultLabel.numberOfLines = 0
        searchResultLabel.isHidden = true
    }
    
    // Set ResultImageView
    private func setResultImageView() {
        resultImageView.image = UIImage(named: "word_logo")
        resultImageView.contentMode = .scaleAspectFill
    }
    
    // Set RecomendButton
    private func setRandomRecomendButton() {
        for (i, button) in recomendWordButtons.enumerated() {
            makeRecomendHistoryButton(button: button, title: recomendedWords[i])
        }
    }
    
    // Set HistoryButton
    private func setHistoryButton() {
        for (i, button) in historyButtons.enumerated() {
            makeRecomendHistoryButton(button: button, title: searchedHistoryWords[i])
        }
    }
    
    // MARK: - Action
    
    // Tap View EndEditing
    @IBAction func didEndEditing(_ sender: Any) {
        view.endEditing(true)
    }
    
    // Tap TextField ReturnKey EndEditing
    @IBAction func didTapReturnKey(_ sender: UITextField) {
        search()
    }
    
    // Tap SearchButton
    @IBAction func didTapSearchButton(_ sender: UIButton) {
        search()
        view.endEditing(true)
    }
    
    // Tap RecomendHistoryButton
    @IBAction func didTapRecomendHistoryButton(_ sender: UIButton) {
        searchTextField.text = sender.currentTitle
        search()
    }
    
    // Swipe Gesture
    @IBAction func reloadSwipe(_ sender: Any) {
        recomendedWords.shuffle()
        
        for i in 0..<recomendWordButtons.count {
            recomendWordButtons[i].setTitle(recomendedWords[i], for: .normal)
        }
    }
}

extension NewWordSearchViewController {
    // MARK: - Make UI Functions
    
    // Make Recomend, History Button UI
    func makeRecomendHistoryButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
    }
    
    // Make Label UI
    func makeLabelUI(label: UILabel, title: String, textColor: UIColor) {
        label.text = title
        label.textColor = textColor
    }
}

extension NewWordSearchViewController {
    // MARK: - Other Functions
    
    // 검색 후 UI 처리
    private func search() {
        searchResultLabel.text = searchedWord()
        searchResultLabel.isHidden = false
        resultImageView.image = UIImage(named: "newWordBackground")
    }
    
    // 신조어 딕셔너리에서 검색
    private func searchedWord() -> String {
        guard let searchedText = searchTextField.text else {
            print("검색 텍스트필드 옵셔널 바인딩 실패")
            return ""
        }
        let upperedText = searchedText.uppercased()
        
        searchedHistoryWords.insert(searchedText, at: 0)
        setHistoryButton()
        
        if let newWord = newWordList[upperedText] {
            return newWord
        } else {
            return "검색 결과가 없습니다"
        }
    }
}
