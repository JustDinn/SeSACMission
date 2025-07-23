//
//  MovieViewController.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import UIKit
import SnapKit

final class MovieViewController: UIViewController, InitialSetProtocol {

    // MARK: - Component
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "영화 검색"
        textField.textColor = .white
        
        return textField
    }()
    
    private let separatingLine = SeparatingLine(color: .white)
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        
        return tableView
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
        view.backgroundColor = .black
    }
    
    func setAddView() {
        [
            searchTextField,
            separatingLine,
            searchButton,
            movieTableView
        ].forEach(view.addSubview)
    }
    
    func setConstraints() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(UIScreen.main.bounds.width * 0.7)
            $0.height.equalTo(44)
        }
        
        separatingLine.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom)
            $0.width.equalTo(searchTextField)
            $0.height.equalTo(1)
        }
        
        searchButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(searchTextField)
            $0.width.equalTo(UIScreen.main.bounds.width * 0.2)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        movieTableView.snp.makeConstraints {
            $0.top.equalTo(separatingLine.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableView DataSource, Delegate

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
