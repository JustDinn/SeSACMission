//
//  InitialSetProtocol.swift
//  SeSACMission21
//
//  Created by HyoTaek on 7/26/25.
//

import Foundation

@objc protocol InitialSetProtocol: AnyObject {
    
    @objc optional func setViewController()
    func setHierarchy()
    func setConstraints()
}
