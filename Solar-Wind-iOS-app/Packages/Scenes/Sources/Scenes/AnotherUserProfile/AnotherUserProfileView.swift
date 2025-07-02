//
//  AnotherUserProfileView.swift
//  Scenes
//
//  Created by Даша Николаева on 30.06.2025.
//

import UIKit
import CommonUI

final class AnotherUserProfileView: View {
    var viewModel: AnotherUserProfile.RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            image.update(rootView: ImageWithFooter(image: UIImage(named: "avatarPlaceholder")!, name: viewModel.username, city: viewModel.city))
            tagsView.update(rootView: TagsView(tags: viewModel.sports))
            aboutView.text = viewModel.about
            daysView.update(rootView: DaysView(days: viewModel.days))
        }
    }
    
    private lazy var header = addGradientHeader(backButton: true)

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var image = SwiftUIHostingView(rootView: ImageWithFooter(image: UIImage(named: "avatarPlaceholder")!, name: "", city: ""))

    private lazy var tagsView = SwiftUIHostingView(rootView: TagsView())

    private lazy var daysView = SwiftUIHostingView(rootView: DaysView(days: []))

    private lazy var aboutView: UILabel = {
        let view = UILabel()
        view.font = .size16Medium
        view.textColor = .black
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func setupContent() {
        super.setupContent()
        backgroundColor = .white

        addSubview(header)
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(image)
        contentView.addSubview(tagsView)
        contentView.addSubview(aboutView)
        contentView.addSubview(daysView)
    }

    override func setupConstraints() {
        super.setupConstraints()

        NSLayoutConstraint.activate([
            // header
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leftAnchor.constraint(equalTo: leftAnchor),
            header.rightAnchor.constraint(equalTo: rightAnchor),
            header.heightAnchor.constraint(equalToConstant: 100),

            // scrollView
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // contentView inside scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // image
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            image.heightAnchor.constraint(equalToConstant: 300),

            // tagsView
            tagsView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50),
            tagsView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            tagsView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            tagsView.heightAnchor.constraint(equalToConstant: 100),

            // aboutView
            aboutView.topAnchor.constraint(equalTo: tagsView.bottomAnchor, constant: 10),
            aboutView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            aboutView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),

            // daysView
            daysView.topAnchor.constraint(equalTo: aboutView.bottomAnchor, constant: 50),
            daysView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 90),
            daysView.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -16),

            // bottom constraint to scroll
            daysView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
}
