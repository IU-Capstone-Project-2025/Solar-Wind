//
//  SearchView.swift
//  CommonUI
//
//  Created by Даша Николаева on 17.06.2025.
//

import UIKit

public class SearchView: UIView {
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16, weight: .medium)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        textField.leftView = searchIconView
        textField.leftViewMode = .always
        textField.returnKeyType = .search
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        textField.delegate = self
        return textField
    }()
    
    private func setupGradientBorder() {
        let cornerRadius: CGFloat = 20
        let borderWidth: CGFloat = 2
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor.mainPinkColor.cgColor,
            UIColor.purpleColor.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = borderWidth
        shapeLayer.path = UIBezierPath(
            roundedRect: self.bounds.insetBy(dx: borderWidth/2, dy: borderWidth/2),
            cornerRadius: cornerRadius
        ).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        gradientLayer.mask = shapeLayer
        self.layer.addSublayer(gradientLayer)
    }
    
    public override func layoutSubviews() {
        setupGradientBorder()
    }
    
    private lazy var searchIconView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .mainPinkColor
        imageView.frame = CGRect(x: 10, y: 8, width: 24, height: 24)
        view.addSubview(imageView)
        return view
    }()
    
    // MARK: - Properties
    
    public var searchAction: ((String) -> Void)?
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public init(placeholder: String) {
        super.init(frame: .zero)
        searchTextField.placeholder = placeholder
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let searchText = textField.text else { return }
        searchAction?(searchText)
    }
    
    public func setText(_ text: String) {
        searchTextField.text = text
    }
    
}

extension SearchView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
}
