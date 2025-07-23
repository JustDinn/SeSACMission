//
//  InitialSetProtocol.swift
//  SeSACWeek4Mission
//
//  Created by HyoTaek on 7/23/25.
//

import Foundation

@objc protocol InitialSetProtocol: AnyObject {
    
    @objc optional func setUI()
    func setAddView()
    func setConstraints()
}
