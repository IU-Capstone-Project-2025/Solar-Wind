//
//  FillAboutMeView.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

import UIKit
import CommonUI

final class FillAboutMeView: View {
    enum Action {
        case next
        case back
    }

    var actionHandler: (Action) -> Void = { _ in }

    private lazy var header = addGradientHeader(text: "Before you start...", backButton: true) { [weak self] in
        self?.actionHandler(.back)
    }

    private lazy var nextButton: UIButton = {
        let button = GradientButton()
        button.title = "Continue"
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.actionHandler(.next)
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Finally, a few words about you"
        view.font = .size20Medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nameTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var aboutMeTextView: TextView = {
        let textView = TextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Tell about yourself..."
        textView.textColor = .lightGray
        textView.delegate = self
        return textView
    }()

    override func setupContent() {
        backgroundColor = .white
        addSubview(nameTextField)
        addSubview(aboutMeTextView)
        addSubview(titleLabel)
        addSubview(nextButton)
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),

            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),

            aboutMeTextView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            aboutMeTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            aboutMeTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            aboutMeTextView.heightAnchor.constraint(equalToConstant: 120),

            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    // MARK: - Public accessors
    var name: String? {
        nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var aboutMe: String? {
        let text = aboutMeTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        return aboutMeTextView.textColor == .lightGray ? nil : text
    }
}

// MARK: - Placeholder logic
extension FillAboutMeView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "Tell about yourself..."
            textView.textColor = .lightGray
        }
    }
}
