//
//  AnotherUserProfileView.swift
//  Scenes
//
//  Created by Даша Николаева on 30.06.2025.
//

import UIKit
import CommonUI

final class AnotherUserProfileView: View {
    enum Action {
        case back
    }

    var actionHandler: (Action) -> Void = { _ in }
    
    private var isLiked: Bool = false
    var viewModel: AnotherUserProfile.RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            image.update(rootView: ImageWithFooter(image: UIImage(named: "avatarPlaceholder")!, name: viewModel.username, city: viewModel.city))
            tagsView.update(rootView: TagsView(tags: viewModel.sports))
            aboutView.text = viewModel.about
            daysView.update(rootView: DaysView(days: viewModel.days))
        }
    }
    
    private lazy var header = addGradientHeader(backButton: true) { [weak self] in
        self?.actionHandler(.back)
    }

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
    
    private let likeView: HalfCircleView = {
        let view = HalfCircleView()
        let image = UIImage(systemName: "heart")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .medium)
        button.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func likeTapped() {
        isLiked.toggle()
        let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .medium)
        likeButton.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart", withConfiguration: config), for: .normal)
        likeButton.tintColor = isLiked ? .darkPinkColor : .black
    }

    override func setupContent() {
        super.setupContent()
        backgroundColor = .white

        addSubview(header)
        addSubview(scrollView)
        addSubview(likeView)
        likeView.addSubview(likeButton)
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
            tagsView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 70),
            tagsView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            tagsView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            tagsView.heightAnchor.constraint(equalToConstant: 100),

            // aboutView
            aboutView.topAnchor.constraint(equalTo: tagsView.bottomAnchor, constant: 10),
            aboutView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            aboutView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),

            // daysView
            daysView.topAnchor.constraint(equalTo: aboutView.bottomAnchor, constant: 50),
            daysView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            daysView.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -16),

            // bottom constraint to scroll
            daysView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            
            likeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            likeView.rightAnchor.constraint(equalTo: rightAnchor),
            likeView.heightAnchor.constraint(equalToConstant: 120),
            likeView.widthAnchor.constraint(equalToConstant: 60),
            
            likeButton.centerXAnchor.constraint(equalTo: likeView.centerXAnchor),
            likeButton.centerYAnchor.constraint(equalTo: likeView.centerYAnchor)
        ])
    }
}
