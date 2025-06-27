//
//  TextView.swift
//  CommonUI
//
//  Created by Даша Николаева on 22.06.2025.
//

import UIKit

public final class TextView: UITextView {

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .white
        textColor = .black
        font = .systemFont(ofSize: 16)

        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 8.0
        clipsToBounds = true

        textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        textContainer.lineFragmentPadding = 0
    }
}
