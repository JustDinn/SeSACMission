//
//  MovieViewController.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/24/25.
//

import UIKit
import SnapKit
import Alamofire

final class MovieViewController: UIViewController, InitialSetProtocol {

    // MARK: - Properties
    
//    private var movies = MovieInfo.movies
    private var movies: [MovieInfo] = []
    
    // MARK: - Component
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        
        textField.delegate = self
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
        button.addTarget(self, action: #selector(didTapSearhButton), for: .touchUpInside)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestGetMovie()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        view.backgroundColor = .black
    }
    
    // MARK: - Set AddView
    
    func setAddView() {
        [
            searchTextField,
            separatingLine,
            searchButton,
            movieTableView
        ].forEach(view.addSubview)
    }
    
    // MARK: - Set Constraints
    
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
    
    // MARK: - Action
    
//    // 영화 섞고 테이블뷰 리로드
//    private func shuffleMovies() {
//        movies = MovieInfo.randomMovies
//        movieTableView.reloadData()
//    }
    
    // 검색 버튼 탭할 경우
    @objc private func didTapSearhButton() {
//        shuffleMovies()
    }
    
    // MARK: - API Calling
    
    private func requestGetMovie() {
        guard let movieAPIKey = Bundle.main.infoDictionary?["BOX_OFFICE_API_KEY"] as? String else {
            print("<< movie key 바인딩 실패")
            return
        }
        
        print("<< key: \(movieAPIKey)")
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(movieAPIKey)&targetDt=20120101"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseString { response in
                print("<< 응답: \(response)")
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
        let cellIndex = indexPath.row
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.configureCell(movie: movies[cellIndex], index: cellIndex + 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

// MARK: - UITextField Delegate

extension MovieViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shuffleMovies()
        
        return true
    }
}
