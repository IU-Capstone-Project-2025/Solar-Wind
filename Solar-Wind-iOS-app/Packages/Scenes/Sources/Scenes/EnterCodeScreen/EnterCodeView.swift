//
//  EnterCodeView.swift
//  Scenes
//
//  Created by Даша Николаева on 13.07.2025.
//

import UIKit
import CommonUI

final class EnterCodeView: View {
    enum Action {
        case next(String)
    }
    
    var actionHandler: (Action) -> Void = { _ in }
    
    private lazy var header = addGradientHeader(text: "Before you start...")
    
    private let textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .numberPad
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        view.textColor = .black
        view.placeholder = "Enter code"
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkPinkColor.cgColor
        
        view.setLeftPadding(16)
        view.setRightPadding(16)

        return view
    }()

    
    private lazy var nextButton: UIButton = {
        let button = GradientButton()
        button.title = "Continue"
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.actionHandler(.next(self?.textField.text ?? ""))
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupContent() {
        backgroundColor = .white
        addSubview(header)
        addSubview(textField)
        addSubview(nextButton)
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 48),
            textField.widthAnchor.constraint(equalToConstant: 200),

            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}

private extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }

    func setRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
