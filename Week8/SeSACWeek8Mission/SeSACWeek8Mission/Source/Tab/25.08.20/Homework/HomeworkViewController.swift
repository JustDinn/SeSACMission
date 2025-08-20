//
//  HomeworkViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import SnapKit

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let profileImage: String
}

class HomeworkViewController: UIViewController {
    
    let sampleUsers: [Person] = [
        Person(name: "Steven", email: "steven.brown@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/1.jpg"),
        Person(name: "Mike", email: "mike.wilson@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/2.jpg"),
        Person(name: "Emma", email: "emma.taylor@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/1.jpg"),
        Person(name: "James", email: "james.anderson@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/3.jpg"),
        Person(name: "Lisa", email: "lisa.martin@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/2.jpg"),
        Person(name: "John", email: "john.davis@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/4.jpg"),
        Person(name: "Sarah", email: "sarah.white@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/3.jpg"),
        Person(name: "David", email: "david.miller@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/5.jpg"),
        Person(name: "Laura", email: "laura.jones@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/4.jpg"),
        Person(name: "Tom", email: "tom.wilson@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/6.jpg"),
        Person(name: "Amy", email: "amy.clark@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/5.jpg"),
        Person(name: "Paul", email: "paul.harris@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/7.jpg"),
        Person(name: "Karen", email: "karen.lewis@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/6.jpg"),
        Person(name: "Mark", email: "mark.lee@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/8.jpg"),
        Person(name: "Helen", email: "helen.young@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/7.jpg"),
        Person(name: "Ryan", email: "ryan.walker@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/9.jpg"),
        Person(name: "Lucy", email: "lucy.hall@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/8.jpg"),
        Person(name: "Eric", email: "eric.allen@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/10.jpg"),
        Person(name: "Kate", email: "kate.king@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/9.jpg"),
        Person(name: "Brian", email: "brian.scott@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/11.jpg"),
        Person(name: "Nancy", email: "nancy.green@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/10.jpg"),
        Person(name: "Chris", email: "chris.baker@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/12.jpg"),
        Person(name: "Diana", email: "diana.adams@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/11.jpg"),
        Person(name: "Kevin", email: "kevin.hill@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/13.jpg"),
        Person(name: "Julia", email: "julia.wright@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/12.jpg"),
        Person(name: "Gary", email: "gary.nelson@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/14.jpg"),
        Person(name: "Rachel", email: "rachel.carter@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/13.jpg"),
        Person(name: "Frank", email: "frank.mitchell@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/15.jpg"),
        Person(name: "Alice", email: "alice.perez@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/14.jpg"),
        Person(name: "Scott", email: "scott.roberts@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/16.jpg"),
        Person(name: "Maria", email: "maria.turner@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/15.jpg"),
        Person(name: "Peter", email: "peter.phillips@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/17.jpg"),
        Person(name: "Sandra", email: "sandra.campbell@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/16.jpg"),
        Person(name: "Jeff", email: "jeff.parker@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/18.jpg"),
        Person(name: "Paula", email: "paula.evans@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/17.jpg"),
        Person(name: "Doug", email: "doug.edwards@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/19.jpg"),
        Person(name: "Linda", email: "linda.collins@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/18.jpg"),
        Person(name: "Steve", email: "steve.stewart@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/20.jpg"),
        Person(name: "Carol", email: "carol.morris@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/19.jpg"),
        Person(name: "Dan", email: "dan.rogers@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/21.jpg"),
        Person(name: "Ruth", email: "ruth.reed@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/20.jpg"),
        Person(name: "Greg", email: "greg.cook@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/22.jpg"),
        Person(name: "Betty", email: "betty.morgan@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/21.jpg"),
        Person(name: "Alex", email: "alex.bell@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/23.jpg"),
        Person(name: "Janet", email: "janet.murphy@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/22.jpg"),
        Person(name: "Phil", email: "phil.bailey@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/24.jpg"),
        Person(name: "Judy", email: "judy.rivera@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/23.jpg"),
        Person(name: "Larry", email: "larry.cooper@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/25.jpg"),
        Person(name: "Rose", email: "rose.richardson@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/24.jpg"),
        Person(name: "Ralph", email: "ralph.cox@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/26.jpg"),
        Person(name: "Ann", email: "ann.howard@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/25.jpg")
    ]
    
    let tableView = UITableView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    let searchBar = UISearchBar()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
     
    private func bind() {
          
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
         
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }

}
 
