//
//  BooksViewController.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

protocol BooksViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidDisappear()
    func viewWillAppear()
    func viewDidSelectBook(_ book: BookEntity)
}

protocol BooksViewInputProtocol: AnyObject {
    func setupView()
    func reload(with rows: [BooksTableRowType], animated: Bool)
}

final class BooksViewController: BaseViewController {
    weak var output: BooksViewOutputProtocol? {
        didSet { basePresenter = output as? BasePresenter }
    }
    
    private var adapter: BooksTableAdapter?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - BooksViewInputProtocol
extension BooksViewController: BooksViewInputProtocol {
    func setupView() {
        setupNavigationBar()
        adapter = .init(tableView: tableView, output: self)
        [tableView].forEach(view.addSubview(_:))
        configureConstraints()
    }
    
    func reload(with rows: [BooksTableRowType], animated: Bool) {
        adapter?.reload(with: rows, animated: animated)
    }
}

// MARK: - BooksTableAdapterOutput
extension BooksViewController: BooksTableAdapterOutput {
    func didSelectBook(_ adapter: BooksTableAdapterInput, book: BookEntity) {
        output?.viewDidSelectBook(book)
    }
}

// MARK: - Private methods
private extension BooksViewController {
    func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        navigationController?.title = "Books" // TODO: - Add localizable strings
    }
}
