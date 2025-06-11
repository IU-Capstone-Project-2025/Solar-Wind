//
//  UIView+background.swift
//  CommonUI
//
//  Created by Даша Николаева on 11.06.2025.
//

import UIKit

public extension UIView {
    func addGradientBackgroundView() {
        let bg = GradientBackgroundView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(bg, at: 0)
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor),
            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

