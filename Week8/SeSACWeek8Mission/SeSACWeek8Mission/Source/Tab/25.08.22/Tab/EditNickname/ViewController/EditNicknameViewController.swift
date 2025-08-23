//
//  EditNicknameViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/23/25.
//

import UIKit
import SnapKit
import Then

final class EditNicknameViewController: UIViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        setBackButtonNaviBar("대장님 이름 정하기")
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveNickname)
        )
        self.navigationController?.navigationBar.tintColor = .tint
    }
    
    // MARK: - Objc Function
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveNickname() {
        
    }
}
