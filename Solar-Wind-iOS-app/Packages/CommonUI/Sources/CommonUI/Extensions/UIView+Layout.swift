//
//  UIView+Layout.swift
//  CommonUI
//
//  Created by Даша Николаева on 19.06.2025.
//

import UIKit

public extension UIView {
    func pinToSuperview(left: CGFloat = 0, top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
        guard let pinView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: pinView.leftAnchor, constant: left).isActive = true
        topAnchor.constraint(equalTo: pinView.topAnchor, constant: top).isActive = true
        rightAnchor.constraint(equalTo: pinView.rightAnchor, constant: -right).isActive = true
        bottomAnchor.constraint(equalTo: pinView.bottomAnchor, constant: -bottom).isActive = true
    }
    
    func pinToSuperview(padding: CGFloat) {
        pinToSuperview(left: padding, top: padding, right: padding, bottom: padding)
    }
}
