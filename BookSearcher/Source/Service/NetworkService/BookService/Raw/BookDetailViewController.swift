//
//  BookDetailViewController.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

protocol BookDetailViewOutputProtocol: AnyObject {
    func viewDidLoad()
}

protocol BookDetailViewInputProtocol: AnyObject {
    func setupView()
    func updateTitle(_ title: String)
    func reload(with rows: [BookDetailTableRowType], animated: Bool)
}

final class BookDetailViewController: BaseViewController {
    weak var output: BookDetailViewOutputProtocol? {
        didSet { basePresenter = output as? BasePresenter }
    }
        
    private var adapter: BookDetailTableAdapter?
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

// MARK: - BookDetailViewInputProtocol
extension BookDetailViewController: BookDetailViewInputProtocol {
    func setupView() {
        view.backgroundColor = .white
        
        adapter = .init(tableView: tableView, output: self)
        [tableView].forEach(view.addSubview(_:))
        configureConstraints()
    }
    
    func updateTitle(_ title: String) {
//        navigationController?.title = title
        self.title = title
    }
    
    func reload(with rows: [BookDetailTableRowType], animated: Bool) {
        adapter?.reload(with: rows, animated: animated)
    }
}

// MARK: - BookDetailTableAdapterOutput
extension BookDetailViewController: BookDetailTableAdapterOutput {
}

// MARK: - Private methods
private extension BookDetailViewController {
    func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
