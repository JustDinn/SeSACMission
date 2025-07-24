//
//  LottoViewController.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

final class LottoViewController: UIViewController, InitialSetProtocol {

    // MARK: - Properties
    
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
        
        label.textColor = .gray
        
        return label
    }()
    
    private let separatingLine = SeparatingLine(color: .systemGray4)
    
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
    
    private let bonusLabel: UILabel = {
        let label = UILabel()
        
        label.text = "보너스"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .medium)
        
        return label
    }()
    
    private lazy var pushButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("영화 페이지", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapPushButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAddView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedLottoRound = "\(LottoData.latestLotteryRound)회 당첨결과"
        updateLatestRound()
        requestGetLotto()
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
            lottoNumberCollectionView,
            bonusLabel,
            pushButton
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
        
        bonusLabel.snp.makeConstraints {
            $0.top.equalTo(lottoNumberCollectionView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(32)
            $0.width.equalTo(36)
        }
        
        pushButton.snp.makeConstraints {
            $0.top.equalTo(bonusLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(84)
            $0.height.equalTo(44)
        }
    }
    
    // MARK: - Action
    
    @objc private func didTapPushButton() {
        DispatchQueue.main.async {
            self.pushMovieVC()
        }
    }
}

// MARK: - API Calling

extension LottoViewController {
    
    // 로또 정보 가져오기
    func requestGetLotto() {
        AF.request(LottoData.lottoRequestURL, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LottoModel.self) { response in
                switch response.result {
                case .success(let lottoInfo):
                    self.saveAllLottoNumbers(lottoInfo: lottoInfo)
                    
                    DispatchQueue.main.async {
                        self.setDateLabel(drawnDate: lottoInfo.drawnDate)
                        UIView.performWithoutAnimation {
                            self.lottoNumberCollectionView.reloadData()
                        }
                    }
                    
                case .failure(let error):
                    print("<< 실패 응답: \(error.localizedDescription)")
                }
            }
    }
}

// MARK: - Process API Response

extension LottoViewController {
    
    // 로또 정보 저장하기
    func saveAllLottoNumbers(lottoInfo: LottoModel) {
        LottoData.lottoNumbers[0].number = String(lottoInfo.lottoNumber1)
        LottoData.lottoNumbers[1].number = String(lottoInfo.lottoNumber2)
        LottoData.lottoNumbers[2].number = String(lottoInfo.lottoNumber3)
        LottoData.lottoNumbers[3].number = String(lottoInfo.lottoNumber4)
        LottoData.lottoNumbers[4].number = String(lottoInfo.lottoNumber5)
        LottoData.lottoNumbers[5].number = String(lottoInfo.lottoNumber6)
        LottoData.lottoNumbers[7].number = String(lottoInfo.lottoBonusNumber)
    }
    
    // 당첨 날짜 label 설정
    func setDateLabel(drawnDate: String) {
        dateLabel.text = "\(drawnDate) 추첨"
    }
    
    // 가장 최신 회차 저장
    func updateLatestRound() {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
        
        guard let responseToDate = dateFormatter.date(from: "2025-07-19") else {
            print("<< 로또 당첨일 Date 변환 실패")
            return
        }
        
        // 기준일은 항상 7월 19일로 고정임. 즉, 과거가 될 가능성이 없기 때문에 회차를 빼줄 가능성이 없어서 더해주기만 하면 됨
        let dateGap = getDateGap(responseDate: responseToDate)
        let roundGap = dateGap / 7
        
        // 일주일 이상 차이날 경우 1회차를 더한 회차의 로또 번호를 요청
        if roundGap > 0 {
            LottoData.latestLotteryRound += roundGap
        }
    }
    
    // 날짜 차이 계산
    func getDateGap(responseDate: Date) -> Int {
        let dateGap = Calendar.current.getDateGap(from: responseDate, to: Date())
        
        return dateGap
    }
}

// MARK: - UICollectionView DataSource

extension LottoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LottoData.lottoNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LottoNumberCollectionViewCell.identifier, for: indexPath) as! LottoNumberCollectionViewCell
        let cellIndex = indexPath.item
        
        cell.configureCell(with: LottoData.lottoNumbers[cellIndex])
        
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
        return String(LottoData.lottoRound[row])
    }
        
    // 아이템 선택
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lottoNumberTextField.text = String(LottoData.lottoRound[row])
        selectedLottoRound = "\(LottoData.lottoRound[row])회 당첨결과"
        LottoData.latestLotteryRound = LottoData.lottoRound[row]
        requestGetLotto()
    }
}
