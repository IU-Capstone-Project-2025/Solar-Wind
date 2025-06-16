//
//  WelcomeView.swift
//  Scenes
//
//  Created by Даша Николаева on 10.06.2025.
//

import UIKit
import CommonUI

final class WelcomeView: View {
    enum Action {
        case next
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    var viewModel: Welcome.RootViewModel? {
        didSet {
            guard let viewModel else { return }
        }
    }
    
    private let logoImageView: UIImageView = {
//        let view = UIImageView()
        let view = UIImageView(image: UIImage(named: "logo"))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Solar Wind"
        view.textColor = .darkPinkColor
        view.font = .size50Bold
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sloganLabel: UILabel = {
        let view = UILabel()
        view.font = .size24Medium
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 2
        view.text = "Move. Meet. Repeat."
        view.shadowColor = .darkPinkColor
        view.shadowOffset = .init(width: 1, height: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nextButton: WhiteButton = {
        let view = WhiteButton()
        view.title = "Find your gym bro"
        view.addAction(
            UIAction(
                handler: { [weak self] _ in
                    self?.actionHandler(.next)
                }
            ),
            for: .touchUpInside
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupContent() {
        addGradientBackgroundView()
        addSubview(logoImageView)
        addSubview(sloganLabel)
        addSubview(nextButton)
        addSubview(nameLabel)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 260),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 140),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            sloganLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -20),
            sloganLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -230),
            sloganLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
