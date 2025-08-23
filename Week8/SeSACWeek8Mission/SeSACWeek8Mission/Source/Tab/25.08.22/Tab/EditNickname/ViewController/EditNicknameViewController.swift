//
//  EditNicknameViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/23/25.
//

import UIKit
import SnapKit
import Then

import RxSwift
import RxCocoa

final class EditNicknameViewController: UIViewController {

    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - ViewModel
    
    private let editNicknameViewModel = EditNicknameViewModel()
    
    // MARK: - Component
    
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요"
    }
    
    private var saveButton = UIBarButtonItem()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setConstraints()
        bind()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        setBackButtonNaviBar("대장님 이름 정하기")
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            nicknameTextField
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        let input = EditNicknameViewModel.Input(
            saveButtonTapped: saveButton.rx.tap,
            nickname: nicknameTextField.rx.text.orEmpty
        )
        let output = editNicknameViewModel.transform(input: input)
        
        output.resultMessage
            .bind(with: self) { owner, message in
                owner.view.showToast(message)
            }
            .disposed(by: disposeBag)
    }
}

extension EditNicknameViewController {
    
    // 타이틀, 왼쪽, 오른쪽 버튼 네비바
    func setBackButtonNaviBar(_ title: String) {
        let titleLabel = UILabel().then {
            $0.setLabel(text: title, fontSize: 18, fontWeight: .black, textColor: .tint)
        }
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(popVC)
        )
        saveButton = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: nil,
            action: nil
        )
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationController?.navigationBar.tintColor = .tint
    }
    
    // MARK: - Objc Function
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
}
