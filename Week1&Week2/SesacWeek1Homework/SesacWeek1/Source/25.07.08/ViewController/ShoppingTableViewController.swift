//
//  ShoppingTableViewController.swift
//  SesacWeek1Homework
//
//  Created by HyoTaek on 7/10/25.
//

import UIKit

struct Item {
    let title: String
    var isPerchased: Bool
    var isBookMarked: Bool
}

struct Drama {
    let title: String
    let rating: Double
    let poster: String
}

class ShoppingTableViewController: UITableViewController {

    // MARK: - Properties
    
    var shoppingList: [Item] = []
    var purchasedList: [Item] = []
    
    let dramaList = [
        Drama(title: "", rating: 0.0, poster: "")
    ]
    
    // MARK: - Components
    
    @IBOutlet var addItemView: UIView!
    @IBOutlet var addingView: UIView!
    @IBOutlet var shoppingTextField: UITextField!
    @IBOutlet var addItemButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setTextField()
        setButton()
    }
    
    // MARK: - Set View
    
    func setView() {
        addItemView.backgroundColor = .white
        addingView.layer.cornerRadius = 10
        addingView.layer.masksToBounds = true
        addingView.backgroundColor = .systemGray6
    }
    
    // MARK: - Set TextField
    
    func setTextField() {
        shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingTextField.borderStyle = .none
        shoppingTextField.textColor = .black
        shoppingTextField.backgroundColor = .systemGray6
    }
    
    // MARK: - Set Button

    func setButton() {
        addItemButton.setTitle("추가", for: .normal)
        addItemButton.setTitleColor(.black, for: .normal)
        addItemButton.backgroundColor = .systemGray5
        addItemButton.layer.cornerRadius = 10
    }
    
    // MARK: - Action

    @IBAction func didTapAddItemButton(_ sender: UIButton) {
        if let itemTitle = shoppingTextField.text {
            if !itemTitle.isEmpty {
                shoppingList.append(Item(title: itemTitle, isPerchased: false, isBookMarked: false))
                tableView.reloadData()
            }
        }
    }
    
    @objc func didTapPurchase(_ sender: UIButton) {
        let section = sender.tag / 10
        let row = sender.tag % 10
        
        if section == 0 {
            var item = shoppingList[row]
            item.isPerchased.toggle()
            
            shoppingList.remove(at: row)
            purchasedList.append(item)
        } else if section == 1 {
            var item = purchasedList[row]
            item.isPerchased.toggle()
            
            purchasedList.remove(at: row)
            shoppingList.append(item)
        }
        
        tableView.reloadData()
    }
    
    @objc func didTapBookMark(_ sender: UIButton) {
        let section = sender.tag / 10
        let row = sender.tag % 10
        
        if section == 0 {
            shoppingList[row].isBookMarked.toggle()
        } else if section == 1 {
            purchasedList[row].isBookMarked.toggle()
        }
        
        tableView.reloadData()
    }
    
    // MARK: - UITableView DataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "미구매 목록"
        case 1:
            return "구매 목록"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return shoppingList.count
        case 1:
            return purchasedList.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as! ShoppingTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.configureCell(
                title: shoppingList[indexPath.row].title,
                isPerchased: shoppingList[indexPath.row].isPerchased,
                isBookMarked: shoppingList[indexPath.row].isBookMarked
            )
            
        case 1:
            cell.configureCell(
                title: purchasedList[indexPath.row].title,
                isPerchased: purchasedList[indexPath.row].isPerchased,
                isBookMarked: purchasedList[indexPath.row].isBookMarked
            )
            
        default:
            fatalError("잘못된 섹션이당")
        }
        
        // TODO: 데이터의 개수가 3자리, 4자리, 5자리.... 등등에도 적용될 수 있도록 보완
        let setcionRowSum = "\(indexPath.section)\(indexPath.row)"
        
        guard let tag = Int(setcionRowSum) else {
            print("정수 변환 실패")
            return UITableViewCell()
        }
        
        cell.checkImageButton.tag = tag
        cell.checkImageButton.addTarget(self, action: #selector(didTapPurchase(_:)), for: .touchUpInside)
        cell.bookMarkButton.tag = tag
        cell.bookMarkButton.addTarget(self, action: #selector(didTapBookMark(_:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 0 {
            let deleteAction = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
                self.shoppingList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                success(true)
            }
            deleteAction.backgroundColor = .systemRed
            deleteAction.image = UIImage(systemName: "trash.fill")
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        } else if indexPath.section == 1 {
            let deleteAction = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
                self.purchasedList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                success(true)
            }
            deleteAction.backgroundColor = .systemRed
            deleteAction.image = UIImage(systemName: "trash.fill")
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        } else {
            fatalError("스와이프 제스처 fatal error")
        }
    }
}
