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
    private var filteredChaingList = ChatList.list
    
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
        searchBar.searchTextField.addTarget(self, action: #selector(didEndEditing), for: .editingDidEndOnExit)
        searchBar.searchTextField.addTarget(self, action: #selector(didChangedEditing), for: .editingChanged)
    }
    
    // MARK: - 채팅 데이터를 날짜별로 섹션 나누기
    
    private func toSectionedChatting(indexPath: IndexPath) -> [[Chat]] {
        var newChatting: [[Chat]] = []
        var sectionChatting: [Chat] = []
        var initialDate = filteredChaingList[indexPath.item].chatList[0].date
            
        filteredChaingList[indexPath.item].chatList.forEach {
            if $0.date.prefix(10) != initialDate.prefix(10) {
                initialDate = String($0.date)
                newChatting.append(sectionChatting)
                sectionChatting.removeAll()
            }
            sectionChatting.append($0)
        }
        newChatting.append(sectionChatting)
        
        return newChatting
    }
    
    // MARK: - Action
    
    // 채팅방 필터
    
    private func filterChattingRoom(searchingKeyword: String) {
        // 빈 값 입력 시 초기화
        if searchingKeyword.isEmpty {
            filteredChaingList = chatingList
        } else {
            filteredChaingList = chatingList.filter { $0.chatroomName.contains(searchingKeyword) }
        }
        talkCollectionView.reloadData()
    }
    
    // 엔터, search 눌렀을 경우
    @objc private func didEndEditing() {
        let searchKeyword = searchBar.searchTextField.text!.trimmingCharacters(in: .whitespaces)
        
        filterChattingRoom(searchingKeyword: searchKeyword)
    }
    
    // 서치바의 입력 내용이 변경될 경우
    @objc private func didChangedEditing() {
        let searchKeyword = searchBar.searchTextField.text!.trimmingCharacters(in: .whitespaces)
        
        filterChattingRoom(searchingKeyword: searchKeyword)
    }
}

// MARK: - UICollectionView DataSource

extension TravelTalkViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredChaingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelTalkCollectionViewCell.identifier, for: indexPath) as! TravelTalkCollectionViewCell
        let cellIndex = indexPath.item
        
        cell.configureCell(with: filteredChaingList[cellIndex])
        
        return cell
    }
}

// MARK: - UICollectionView Delegate

extension TravelTalkViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let talkTableVC = self.storyboard?.instantiateViewController(withIdentifier: "TravelTalkTableViewController") as! TravelTalkTableViewController
        
        talkTableVC.hidesBottomBarWhenPushed = true
        talkTableVC.navigationItem.title = filteredChaingList[indexPath.item].chatroomName
        talkTableVC.chatRoomInfo = toSectionedChatting(indexPath: indexPath)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        navigationController?.pushViewController(talkTableVC, animated: true)
    }
}
