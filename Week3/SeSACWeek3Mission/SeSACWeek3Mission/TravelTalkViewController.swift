//
//  ViewController.swift
//  SeSACWeek3Mission
//
//  Created by HyoTaek on 7/20/25.
//

import UIKit

final class TravelTalkViewController: UIViewController {

    // MARK: - Properties
    
    private var chatingList = ChatList.list
    
    // MARK: - Components
    
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var talkCollectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
        setCollectionView()
    }
    
    // MARK: - CollectionView 설정
    
    private func setCollectionView() {
        let nib = UINib(nibName: "TravelTalkCollectionViewCell", bundle: nil)
        let layout = UICollectionViewFlowLayout()
        let horizontalSpacing = 16
        let width = UIScreen.main.bounds.width - CGFloat(horizontalSpacing * 2)
        let height: Double = 80
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 16
        
        talkCollectionView.register(nib, forCellWithReuseIdentifier: TravelTalkCollectionViewCell.identifier)
        talkCollectionView.collectionViewLayout = layout
        talkCollectionView.dataSource = self
        talkCollectionView.delegate = self
        talkCollectionView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - 검색바 설정
    
    private func setSearchBar() {
        searchBar.placeholder = "친구 이름을 검색해보세요"
        searchBar.searchBarStyle = .minimal
    }
}

// MARK: - UICollectionView DataSource

extension TravelTalkViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelTalkCollectionViewCell.identifier, for: indexPath) as! TravelTalkCollectionViewCell
        let cellIndex = indexPath.item
        
        cell.configureCell(with: chatingList[cellIndex])
        
        return cell
    }
}

// MARK: - UICollectionView Delegate

extension TravelTalkViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let talkTableVC = self.storyboard?.instantiateViewController(withIdentifier: "TravelTalkTableViewController") as! TravelTalkTableViewController
        
        talkTableVC.hidesBottomBarWhenPushed = true
        talkTableVC.navigationItem.title = chatingList[indexPath.item].chatroomName

        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        navigationController?.pushViewController(talkTableVC, animated: true)
    }
}
