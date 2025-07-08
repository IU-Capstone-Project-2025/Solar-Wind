//
//  MyProfileView.swift
//  Scenes
//
//  Created by Даша Николаева on 04.07.2025.
//

import UIKit
import CommonUI

final class MyProfileView: View {
    enum Action {
        case logout
        case back
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    lazy var header = addGradientHeader(text: "My profile", backButton: true) { [weak self] in
        self?.actionHandler(.back)
    }
    
    private lazy var logoutButton: UIButton = {
        let view = UIButton()
        view.setTitle("Log out", for: .normal)
        view.setTitleColor(.darkPinkColor, for: .normal)
        view.titleLabel?.font = .size24Medium
        view.addAction(UIAction(handler: {[weak self] _ in self?.actionHandler(.logout)}), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupContent() {
        backgroundColor = .white
        addSubview(logoutButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
