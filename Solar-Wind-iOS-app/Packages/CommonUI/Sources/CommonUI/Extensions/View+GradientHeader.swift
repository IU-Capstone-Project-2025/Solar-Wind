//
//  View+GradientHeader.swift
//  CommonUI
//
//  Created by Даша Николаева on 15.06.2025.
//

import UIKit

public extension UIView {
    func addGradientHeader(text: String? = nil, backButton: Bool = true) -> UIView {
        let header = GradientBackgroundView()
        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
        
        if let text = text {
            configureHeagerText(to: header, text: text)
        }
        
        if backButton {
            addBackButton(to: header)
        }
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.bottomAnchor.constraint(equalTo: topAnchor, constant: 110),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        return header
    }
    
    private func configureHeagerText(to header: GradientBackgroundView, text: String) {
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
    
    private func addBackButton(to header: GradientBackgroundView) {
        lazy var button: UIButton = {
            let view = UIButton()
            let image = UIImage(systemName: "arrow.uturn.left")
            image?.withTintColor(.white)
            view.setImage(image, for: .normal)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        header.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -16),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 3)
        ])
    }
}
