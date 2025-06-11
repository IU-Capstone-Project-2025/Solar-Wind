//
//  WelcomeView.swift
//  Scenes
//
//  Created by Даша Николаева on 10.06.2025.
//

import UIKit
import CommonUI

final class WelcomeView: UIView {
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
        let view = UIImageView(image: UIImage(named: "logo"))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sloganLabel: UILabel = {
        let view = UILabel()
        view.font = .size24Medium
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 2
        view.text = "Find someone who will\nget the most out of you"
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
    
    private func setupContent() {
        addGradientBackgroundView()
        addSubview(logoImageView)
        addSubview(sloganLabel)
        addSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: sloganLabel.topAnchor, constant: 0)
            sloganLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: 80)
            sloganLabel.
        ])
    }
    
    public init() {
        setupContent()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
