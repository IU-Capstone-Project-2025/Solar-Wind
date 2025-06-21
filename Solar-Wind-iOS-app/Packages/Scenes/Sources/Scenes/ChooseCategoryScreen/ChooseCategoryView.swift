//
//  ChooseCategoryView.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit
import CommonUI

final class ChooseCategoryView: View {
    enum Action {
        case next
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Choose your training categories"
        view.font = .size20Medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var header = addGradientHeader(text: "Before you start...")
    
    private lazy var nextButton: UIButton = {
        let button = PurpleButton()
        button.title = "Continue"
        button.addAction(
            UIAction(handler:
                        { [weak self] _ in
                            self?.actionHandler(.next)
                        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupContent() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(nextButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 32),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
