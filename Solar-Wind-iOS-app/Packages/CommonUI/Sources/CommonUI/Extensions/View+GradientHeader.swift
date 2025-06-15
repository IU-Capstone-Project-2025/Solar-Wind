//
//  View+GradientHeader.swift
//  CommonUI
//
//  Created by Даша Николаева on 15.06.2025.
//

import UIKit

public extension UIView {
    func addGradientHeader() -> UIView {
        let header = GradientBackgroundView()
        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.bottomAnchor.constraint(equalTo: topAnchor, constant: 110),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        return header
    }
}
