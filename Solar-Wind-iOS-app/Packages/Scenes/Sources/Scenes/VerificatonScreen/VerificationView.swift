//
//  VerificationView.swift
//  Scenes
//
//  Created by Даша Николаева on 15.06.2025.
//

import UIKit
import CommonUI

final class VerificationView: View {
    enum Action {
        case openTelegram
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    private let label: UILabel = {
        let view = UILabel()
        view.text = "To continue, tap the button below.\nYour Telegram account data will be shared for authentication."
        view.font = .size20Medium
        view.textColor = .black
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var linkButton: PurpleButton = {
        let view = PurpleButton()
        view.title = "Log in with Telegram"
        view.addAction(
            UIAction(
                handler: { [weak self] _ in
                    self?.actionHandler(.openTelegram)
                }
            ),
            for: .touchUpInside
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var header = addGradientHeader(backButton: false)
    
    override func setupContent() {
        backgroundColor = .white
        addSubview(label)
        addSubview(linkButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 200),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            linkButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            linkButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            linkButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            linkButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
