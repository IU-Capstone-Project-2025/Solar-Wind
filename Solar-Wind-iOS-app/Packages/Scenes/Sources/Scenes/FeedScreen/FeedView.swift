//
//  FeedView.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

import UIKit
import CommonUI
import SwiftUI

final class FeedView: CommonUI.View, UITableViewDelegate {
    enum Action {
        case selected(Int)
        case liked(Int)
        case myProfile
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    var viewModel: Feed.RootViewModel? {
        didSet {
            var snapshot = Snapshot()
            guard let viewModel = viewModel else { return }

            snapshot.appendSections(viewModel.sections)
            viewModel.sections.forEach { section in
                switch section {
                case .items(let items):
                    snapshot.appendItems(items, toSection: section)
                }
            }
            dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    lazy private var header = addGradientHeader(backButton: true, imaheName: "person") { [weak self] in
        self?.actionHandler(.myProfile)
    }
    
    private typealias DataSource = UITableViewDiffableDataSource<Feed.RootViewModel.Section, Feed.RootViewModel.User>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Feed.RootViewModel.Section, Feed.RootViewModel.User>
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
        view.separatorStyle = .none
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.rowHeight = UITableView.automaticDimension
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(
            tableView: tableView
        ) { tableView, indexPath, item in
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
                cell.viewModel = .init(id: item.id, name: item.name, city: item.city, tags: item.tags, description: item.description)
                cell.selectionStyle = .none
                return cell
            default:
                break
            }
            return UITableViewCell()
        }
        return dataSource
    }()
    
    override func setupContent() {
        backgroundColor = .white
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private weak var tableViewDelegate: UITableViewDelegate?
    func setDelegate(_ delegate: UITableViewDelegate) {
        self.tableViewDelegate = delegate
        tableView.delegate = delegate
    }
}

class FeedCell: UITableViewCell {

    var actionHandler: (FeedCellContentView.Action) -> Void {
        get {
            content.actionHandler
        }
        set {
            content.actionHandler = newValue
        }
    }

    var viewModel: FeedCellContentView.Model? {
        get {
            content.viewModel
        }
        set {
            content.viewModel = newValue ?? .init(
                id: -10,
                name: "",
                city: "",
                tags: [],
                description: ""
            )
        }
    }

    private lazy var content: FeedCellContentView = {
        let view = FeedCellContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        view.pinToSuperview()
        return view
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
}

class FeedCellContentView: CommonUI.View {
    private var isLiked: Bool = false

    @objc private func likeTapped() {
        isLiked.toggle()
        if isLiked {
            actionHandler(.liked(viewModel.id))
        }
        likeButton.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        likeButton.tintColor = isLiked ? .red : .lightGray
    }

    public struct Model {
        let id: Int
        let name: String
        let city: String
        let tags: [String]
        let description: String
        var isLiked: Bool

        public init(id: Int, name: String, city: String, tags: [String], description: String, isLiked: Bool = false) {
            self.id = id
            self.name = name
            self.city = city
            self.tags = tags
            self.description = description
            self.isLiked = isLiked
        }
    }
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()

    
    internal lazy var tagsView = SwiftUIHostingView(rootView: TagsView())
    
    public var viewModel: Model = .init(id: -10, name: "", city: "", tags: [], description: "") {
        didSet {
            nameLabel.text = viewModel.name
            cityLabel.text = viewModel.city
            descriptionLabel.text = viewModel.description
            likeButton.setImage(
                UIImage(systemName: viewModel.isLiked ? "heart.fill" : "heart"),
                for: .normal
            )
            likeButton.tintColor = viewModel.isLiked ? .red : .lightGray
            isLiked = viewModel.isLiked
            tagsView.update(rootView: TagsView(tags:viewModel.tags))
        }
    }
    
    public enum Action {
        case pressed
        case liked(Int)
    }
    public var actionHandler: (Action) -> Void = { _ in }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.layer.masksToBounds = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .size20Medium
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .size16Medium
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .size16Medium
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupContent() {
        super.setupContent()
        addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(tagsView)
        containerView.addSubview(cityLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(likeButton)
        backgroundColor = .clear
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            cityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            cityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            tagsView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 36),
            tagsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            tagsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: tagsView.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            likeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            likeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            likeButton.widthAnchor.constraint(equalToConstant: 24),
            likeButton.heightAnchor.constraint(equalToConstant: 24),

        ])
    }
}

extension FeedView {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // Высота отступа между ячейками
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
       guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
       actionHandler(.selected(item.id))
   }
}
