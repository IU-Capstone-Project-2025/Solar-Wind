//
//  UIView+View.swift
//  CommonUI
//
//  Created by Даша Николаева on 15.06.2025.
//

import UIKit

open class View: UIView {
    
    open func setupContent() { }
    open func setupConstraints() { }
    
    public init() {
        super.init(frame: .zero)
        setupContent()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
        setupConstraints()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContent()
        setupConstraints()
    }
}
