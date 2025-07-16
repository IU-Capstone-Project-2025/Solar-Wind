//
//  ChooseCategoryView.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit
import CommonUI
import SwiftUI

final class ChooseCategoryView: CommonUI.View {
    enum Action {
        case next
        case selected(Int)
        case add
        case back
        case search(String)
    }

    var actionHandler: (Action) -> Void = { _ in }
    var searchText: String = ""

    private typealias DataSource = UITableViewDiffableDataSource<ChooseCategory.RootViewModel.Section, ChooseCategory.Category>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ChooseCategory.RootViewModel.Section, ChooseCategory.Category>

    var selectedCategories: [ChooseCategory.Category] = [] {
        didSet {
            updateTags(selectedCategories)
            updateSnapshot()
        }
    }
    
    var selectedIds: [Int] = []

    private var allItems: [ChooseCategory.Category] = []

    var viewModel: ChooseCategory.RootViewModel? {
        didSet {
            updateSnapshot()
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose your training categories"
        label.font = .size20Medium
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var header = addGradientHeader(text: "Before you start...", backButton: true) { [weak self] in
        self?.actionHandler(.back)
    }

    private lazy var searchView: SearchView = {
        let view = SearchView(placeholder: "Search...")
        view.searchAction = { [weak self] text in
            self?.actionHandler(.search(text))
            self?.searchText = text
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tagsView = SwiftUIHostingView<TagsView>(rootView: TagsView())

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.register(CategoryCell.self, forCellReuseIdentifier: "SearchCell")
        table.keyboardDismissMode = .onDrag
        return table
    }()

    private lazy var nextButton: UIButton = {
        let button = GradientButton()
        button.title = "Continue"
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.actionHandler(.next)
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var dataSource: DataSource = {
        let ds = DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! CategoryCell
            cell.viewModel = .init(category: item, isSelected: self.selectedIds.contains(item.id))
            return cell
        }
        return ds
    }()

    override func setupContent() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(searchView)
        addSubview(tagsView)
        addSubview(tableView)
        addSubview(nextButton)
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),

            searchView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 45),

            tagsView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 12),
            tagsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tagsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tagsView.heightAnchor.constraint(equalToConstant: 100),

            tableView.topAnchor.constraint(equalTo:  tagsView.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -12),

            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        tableView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }

    private func updateTags(_ categories: [ChooseCategory.Category]) {
        let tagNames = categories.map { $0.name }
        tagsView.update(rootView: TagsView(tags: tagNames))
    }
    
    private func updateSnapshot() {
        guard let viewModel = viewModel else { return }
        var snapshot = Snapshot()
        snapshot.appendSections(viewModel.sections)
        viewModel.sections.forEach { section in
            switch section {
            case .items(let items):
                let updatedItems = items.map { category in
                    ChooseCategory.Category(id: category.id, name: category.name, isSelected: selectedIds.contains(category.id))
                }
                snapshot.appendItems(updatedItems, toSection: section)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ChooseCategoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = dataSource.itemIdentifier(for: indexPath) else { return }
        if category.isSelected {
            selectedIds.removeAll { $0 == category.id}
        } else {
            selectedIds.append(category.id)
        }
        actionHandler(.selected(category.id))
        updateSnapshot()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let itemsCount = viewModel?.currentItemsCount else { return }
        if searchText == "" && indexPath.row == itemsCount - 5 {
            self.actionHandler(.add)
        }
    }
}

class CategoryCell: UITableViewCell {

    var actionHandler: (CategoryCellContentView.Action) -> Void {
        get {
            content.actionHandler
        }
        set {
            content.actionHandler = newValue
        }
    }

    var viewModel: CategoryCellContentView.Model? {
        get {
            content.viewModel
        }
        set {
            content.viewModel = newValue ?? .init(
                category: .init(id: -1, name: "", isSelected: false)
            )
        }
    }

    private lazy var content: CategoryCellContentView = {
        let view = CategoryCellContentView()
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

class CategoryCellContentView: CommonUI.View {
    public struct Model {
        let category: String
        var isSelected: Bool = false
        
        public init(category: ChooseCategory.Category, isSelected: Bool = false) {
            self.category = category.name
            self.isSelected = isSelected
        }
    }
    
    public var viewModel: Model = .init(category: ChooseCategory.Category(id: -1, name: ""), isSelected: false) {
        didSet {
            categoryLabel.text = viewModel.category
            backgroundColor = viewModel.isSelected ? .orangeColor : .clear
        }
    }
    
    public enum Action {
        case pressed
    }
    public var actionHandler: (Action) -> Void = { _ in }
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .size16Medium
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupContent() {
        super.setupContent()
        addSubview(categoryLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
