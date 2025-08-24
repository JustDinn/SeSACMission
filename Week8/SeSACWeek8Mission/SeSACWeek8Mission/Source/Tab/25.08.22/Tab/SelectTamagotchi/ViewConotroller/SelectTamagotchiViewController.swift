//
//  SelectTamagotchiViewController.swift
//  SeSACWeek8Mission
//
//  Created by HyoTaek on 8/24/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class SelectTamagotchiViewController: UIViewController {

    // MARK: - Property
    
    private let viewModel = TamagotchiViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Component
    
    private lazy var tamagotchiCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 20
        
        $0.collectionViewLayout = layout
        $0.register(TamagotchiCollectionViewCell.self, forCellWithReuseIdentifier: TamagotchiCollectionViewCell.reuseIdentifier)
        $0.backgroundColor = .main
        $0.showsVerticalScrollIndicator = false
    }
    
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
        let tamagotchi = UserDefaults.standard.string(forKey: UserDefaultsKey.tamagotchiName.value)
        
        if tamagotchi == nil {
            setTitleNaviBar("다마고치 시작하기")
        } else {
            setBackNaviBar("다마고치 변경하기")
        }
        view.backgroundColor = .main
    }
    
    // MARK: - Set Hierarchy
    
    private func setHierarchy() {
        [
            tamagotchiCollectionView
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        tamagotchiCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        let output = viewModel.transform()
        
        output.tamagotchiList
            .bind(to: tamagotchiCollectionView.rx.items(
                cellIdentifier: TamagotchiCollectionViewCell.reuseIdentifier,
                cellType: TamagotchiCollectionViewCell.self)
            ) { i, item, cell in
                cell.configureCell(with: item)
            }
            .disposed(by: disposeBag)
        
        tamagotchiCollectionView.rx.modelSelected(TamagotchiModel.self)
            .bind(with: self) { owner, tamagotchi in
                let tamagotchiDetailVC = TamagotchiDetailViewController()
                
                tamagotchiDetailVC.configureVC(with: tamagotchi)
                tamagotchiDetailVC.modalPresentationStyle = .overCurrentContext
                owner.present(tamagotchiDetailVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
