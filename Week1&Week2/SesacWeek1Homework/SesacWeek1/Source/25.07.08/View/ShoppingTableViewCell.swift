//
//  ShoppingTableViewCell.swift
//  SesacWeek1Homework
//
//  Created by HyoTaek on 7/10/25.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    
    // MARK: - Components
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var checkImageButton: UIButton!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var bookMarkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    // MARK: - Set UI
    
    func setUI() {
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 10
        checkImageButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        bookMarkButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    // MARK: - Set Label
    
    func configureCell(title: String, isPerchased: Bool, isBookMarked: Bool) {
        itemTitleLabel.text = title
        
        isPerchased
            ? checkImageButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            : checkImageButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        
        isBookMarked
            ? bookMarkButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            : bookMarkButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
}
