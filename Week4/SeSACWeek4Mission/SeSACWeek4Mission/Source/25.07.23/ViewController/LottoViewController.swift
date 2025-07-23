//
//  LottoViewController.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/23/25.
//

import UIKit
import SnapKit

final class LottoViewController: UIViewController, InitialSetProtocol {

    // MARK: - Component
    
    private lazy var lottoNumberTextField: UITextField = {
        let textField = UITextField()
        
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.textAlignment = .center
        textField.inputView = lottoNumberPickerView
        
        return textField
    }()
    
    private lazy var lottoNumberPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        return pickerView
    }()
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        
        label.text = "당첨번호 안내"
        
        return label
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAddView()
        setConstraints()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        view.backgroundColor = .white
    }
    
    // MARK: - Set AddView
    
    func setAddView() {
        [
            lottoNumberTextField,
            guideLabel
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    func setConstraints() {
        lottoNumberTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(lottoNumberTextField.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(12)
        }
    }
}

// MARK: UIPickerView Delegate

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    // 행의 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    // 행의 아이템 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LottoData.lottoRound.count
    }
        
    // 아이템 데이터
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return LottoData.lottoRound[row]
    }
        
    // 아이템 선택
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lottoNumberTextField.text = LottoData.lottoRound[row]
    }
}
