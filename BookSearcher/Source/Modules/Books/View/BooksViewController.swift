//
//  BooksViewController.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

protocol BooksViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func viewDidSelectBook(_ book: BookEntity)
    func viewDidEndSearching(_ text: String)
}

protocol BooksViewInputProtocol: AnyObject {
    func setupView()
    func reload(with rows: [BooksTableRowType], animated: Bool)
}

final class BooksViewController: BaseViewController {
    weak var output: BooksViewOutputProtocol? {
        didSet { basePresenter = output as? BasePresenter }
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
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
        view.backgroundColor = .white // TODO: - Add color manager
        
        setupNavigationBar()
        adapter = .init(tableView: tableView, output: self)
        [searchBar, tableView].forEach(view.addSubview(_:))
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

// MARK: - UISearchBarDelegate
extension BooksViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard !searchBar.showsCancelButton else { return }
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        output?.viewDidEndSearching(searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        output?.viewDidEndSearching(searchBar.text ?? "")
    }
}

// MARK: - Private methods
private extension BooksViewController {
    func configureConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        title = "Books" // TODO: - Add localizable strings
    }
}
