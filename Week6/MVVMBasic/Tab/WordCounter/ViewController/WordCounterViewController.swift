//
//  WordCounterViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import UIKit
import SnapKit
 
final class WordCounterViewController: UIViewController {
    
    // MARK: - Property
    
    private let wordCounterViewModel = WordCounterViewModel()
    
    // MARK: - Component
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 8
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        textView.delegate = self
        return textView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "현재까지 0글자 작성중"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()
     
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        bindClosure()
    }
     
    // MARK: - Set UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [
            textView,
            countLabel
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setupConstraints() {
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(view.snp.width)
        }
    }
    
    // MARK: - Bind Closure
    
    private func bindClosure() {
        wordCounterViewModel.result = { message in
            self.countLabel.text = message
        }
    }
}
 
// MARK: - UITextView Delegate

extension WordCounterViewController: UITextViewDelegate {
    
    // 텍스트뷰 입력값 변경
    func textViewDidChange(_ textView: UITextView) {
        wordCounterViewModel.text = textView.text
    }
}
