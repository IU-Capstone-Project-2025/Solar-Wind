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
        bg.isUserInteractionEnabled = false
        insertSubview(bg, at: 0)
        bg.clipsToBounds = true
        bg.layer.cornerRadius = layer.cornerRadius
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor),
            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        if let button = self as? BaseRoundButton {
            button.gradientView = bg
        }
    }
}

