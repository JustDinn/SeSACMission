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
        
        requestGetMovie(query: makeYesterday())
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
    
    // 검색 버튼 탭할 경우
    @objc private func didTapSearhButton() {
        addDateQuery()
        searchTextField.endEditing(true)
    }
    
    // 박스오피스 Get 요청 url의 파라미터에 날짜 추가
    private func addDateQuery() {
        requestGetMovie(query: searchTextField.text!)
    }
    
    // MARK: - 어제 날짜 만들기
    
    private func makeYesterday() -> String {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterdayToString = dateFormatter.string(from: yesterday)
        
        return yesterdayToString
    }
}

// MARK: - API Calling

extension MovieViewController {
    
    // 박스 오피스 정보 Get 요청
    private func requestGetMovie(query: String) {
        guard let movieAPIKey = Bundle.main.infoDictionary?["BOX_OFFICE_API_KEY"] as? String else {
            print("<< movie key 바인딩 실패")
            return
        }
        let boxOfficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(movieAPIKey)&targetDt=\(query)"
        
        AF.request(boxOfficeURL, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieModel.self) { response in
                switch response.result {
                case .success(let boxOfficeInfo):
                    self.saveBoxOfficeInfo(boxOfficeInfo: boxOfficeInfo.movie.movieList)
                    
                    DispatchQueue.main.async {
                        UIView.performWithoutAnimation {
                            self.movieTableView.reloadData()
                        }
                    }
                    
                case .failure(let error):
                    print("<< 박스오피스 Get 요청 실패: \(error.localizedDescription)")
                }
            }
    }
}

// MARK: - Process API Response

extension MovieViewController {
    
    // 박스 오피스 정보 저장하기
    func saveBoxOfficeInfo(boxOfficeInfo: [MovieInfo]) {
        movies = boxOfficeInfo
    }
}

// MARK: - UITableView DataSource, Delegate

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        let cellIndex = indexPath.row
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.configureCell(with: movies[cellIndex])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

// MARK: - UITextField Delegate

extension MovieViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addDateQuery()
        textField.endEditing(true)
        
        return true
    }
}
