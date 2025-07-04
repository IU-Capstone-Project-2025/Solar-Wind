//
//  View+GradientHeader.swift
//  CommonUI
//
//  Created by Даша Николаева on 15.06.2025.
//

import UIKit

public extension UIView {
    func addGradientHeader(text: String? = nil, backButton: Bool = true, backButtonAction: (() -> Void)? = nil) -> UIView {
        let header = GradientBackgroundView()
        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
        
        if let text = text {
            configureHeagerText(to: header, text: text)
        }
        
        if backButton, let backButtonAction = backButtonAction {
            addBackButton(to: header, action: backButtonAction)
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
    
    private func addBackButton(to header: GradientBackgroundView, action: @escaping () -> Void) {
        let button = UIButton(type: .system)
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let image = UIImage(systemName: "arrow.uturn.left", withConfiguration: config)?
            .withTintColor(.white, renderingMode: .alwaysOriginal)

        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addAction(UIAction(handler: {_ in action()}), for: .touchUpInside)
        header.addSubview(button)

        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -16),
            button.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 44),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
