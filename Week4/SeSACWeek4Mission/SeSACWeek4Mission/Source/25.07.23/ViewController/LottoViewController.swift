//
//  LottoViewController.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/23/25.
//

import UIKit
import SnapKit

final class LottoViewController: UIViewController, InitialSetProtocol {

    private var selectedLottoRound = "" {
        didSet {
            let attributedStr = NSMutableAttributedString(string: selectedLottoRound)

            attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: (selectedLottoRound as NSString).range(of: "당첨결과"))
            
            lottoRoundTitleLabel.attributedText = attributedStr
        }
    }
    
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
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "\(NowDate.today) 추첨"
        label.textColor = .gray
        
        return label
    }()
    
    private let separatingLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    private let lottoRoundTitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .systemYellow
        
        return label
    }()
    
    private lazy var lottoNumberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 36, height: 36)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(LottoNumberCollectionViewCell.self, forCellWithReuseIdentifier: LottoNumberCollectionViewCell.identifier)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        
        return collectionView
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
            guideLabel,
            dateLabel,
            separatingLine,
            lottoRoundTitleLabel,
            lottoNumberCollectionView
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
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(guideLabel)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        separatingLine.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(1)
        }
        
        lottoRoundTitleLabel.snp.makeConstraints {
            $0.top.equalTo(separatingLine.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        lottoNumberCollectionView.snp.makeConstraints {
            $0.top.equalTo(lottoRoundTitleLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(separatingLine)
            $0.height.equalTo(36)
        }
    }
}

// MARK: - UICollectionView DataSource

extension LottoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LottoNumberCollectionViewCell.identifier, for: indexPath) as! LottoNumberCollectionViewCell
        
        return cell
    }
}

// MARK: - UIPickerView Delegate

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
        selectedLottoRound = "\(LottoData.lottoRound[row])회 당첨결과"
    }
}
