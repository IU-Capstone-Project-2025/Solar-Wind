//  EditAboutMeView.swift
//  Scenes
//
//  Created by Даша Николаева on 15.07.2025.

import UIKit
import CommonUI
import SwiftUI

final class EditAboutMeView: CommonUI.View {
    enum Action {
        case save(_ name: String, _ description: String)
        case back
        case searchCity(String)
        case searchSport(String)
    }

    var actionHandler: (Action) -> Void = { _ in }

    private lazy var header = addGradientHeader(
        text: "Edit info",
        backButton: true,
        rightButton: true,
        rightButtonImageName: "checkmark",
        rightButtonActoin: { [weak self] in
            guard let self else { return }
            self.actionHandler(.save(
                nameTextField.text ?? "",
                aboutTextView.text ?? ""
            ))
        },
        backButtonAction: { [weak self] in
            self?.actionHandler(.back)
        }
    )

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        return scroll
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .size16Medium
        tf.placeholder = "Your name"
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let cityButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Choose city", for: .normal)
        button.setTitleColor(.darkPinkColor, for: .normal)
        button.titleLabel?.font = .size16Medium
        button.contentHorizontalAlignment = .left
        return button
    }()

    private let aboutTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = .size16Medium
        tv.textColor = .black
        tv.layer.cornerRadius = 12
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.backgroundColor = UIColor.white
        tv.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        return tv
    }()

    private let textCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .size16Medium
        label.textColor = .gray
        label.text = "0/300"
        return label
    }()

    private lazy var sportsView = SwiftUIHostingView(rootView: TagsView())

    override func setupContent() {
        backgroundColor = .white
        addSubview(header)
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(nameTextField)
        contentView.addSubview(cityButton)
        contentView.addSubview(aboutTextView)
        contentView.addSubview(textCountLabel)
        contentView.addSubview(sportsView)

        aboutTextView.delegate = self
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leftAnchor.constraint(equalTo: leftAnchor),
            header.rightAnchor.constraint(equalTo: rightAnchor),
            header.heightAnchor.constraint(equalToConstant: 100),

            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nameTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            nameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),

            cityButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            cityButton.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            cityButton.rightAnchor.constraint(equalTo: nameTextField.rightAnchor),
            cityButton.heightAnchor.constraint(equalToConstant: 44),

            aboutTextView.topAnchor.constraint(equalTo: cityButton.bottomAnchor, constant: 20),
            aboutTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            aboutTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            aboutTextView.heightAnchor.constraint(equalToConstant: 160),

            textCountLabel.topAnchor.constraint(equalTo: aboutTextView.bottomAnchor, constant: 4),
            textCountLabel.rightAnchor.constraint(equalTo: aboutTextView.rightAnchor),

            sportsView.topAnchor.constraint(equalTo: textCountLabel.bottomAnchor, constant: 20),
            sportsView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            sportsView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            sportsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
        ])
    }
}

extension EditAboutMeView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let count = textView.text.count
        textCountLabel.text = "\(count)/300"
        if count > 300 {
            textView.text = String(textView.text.prefix(300))
            textCountLabel.text = "300/300"
        }
    }
}
