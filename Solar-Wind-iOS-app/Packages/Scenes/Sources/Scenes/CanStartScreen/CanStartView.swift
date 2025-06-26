//
//  CanStartView.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

import UIKit
import CommonUI

class CanStartView: View {
    enum Action {
        case next
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    private lazy var nextButton: UIButton = {
        let button = WhiteButton()
        button.title = "Let's go!"
        button.addAction(
            UIAction(
                handler: { [weak self] _ in
                    self?.actionHandler(.next)
                }),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let label: UILabel = {
        let view = UILabel()
        view.text = "The questionnaire has been\ncreated, now you can start\nviewing others"
        view.font = .size24Medium
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 3
        view.textAlignment = .center
        return view
    }()
    
    override func setupContent() {
        addGradientBackgroundView()
        addSubview(label)
        addSubview(nextButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
