//
//  View+GradientHeader.swift
//  CommonUI
//
//  Created by Даша Николаева on 15.06.2025.
//

import UIKit

public extension UIView {
    func addGradientHeader(text: String? = nil) -> UIView {
        let header = GradientBackgroundView()
        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
        
        if let text = text {
            configureHeagerText(header: header, text: text)
        }
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.bottomAnchor.constraint(equalTo: topAnchor, constant: 110),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        return header
    }
    
    private func configureHeagerText(header: GradientBackgroundView, text: String) {
        let label: UILabel = {
            let view = UILabel()
            view.text = text
            view.font = .size16Medium
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        header.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -16),
            label.centerXAnchor.constraint(equalTo: header.centerXAnchor)
        ])
    }
}
