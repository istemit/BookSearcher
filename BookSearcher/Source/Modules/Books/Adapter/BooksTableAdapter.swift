//
//  BooksTableAdapter.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

enum BooksTableRowType {
    case book(item: BookEntity)
}

protocol BooksTableAdapterOutput: AnyObject {
    func didSelectBook(_ adapter: BooksTableAdapterInput, book: BookEntity)
}

protocol BooksTableAdapterInput {
    func reload(with rows: [BooksTableRowType], animated: Bool)
}

final class BooksTableAdapter: NSObject {
    private weak var output: BooksTableAdapterOutput?
    private let tableView: UITableView?
    
    private var rows: [BooksTableRowType] = []

    init(tableView: UITableView, output: BooksTableAdapterOutput) {
        self.tableView = tableView
        self.output = output
        super.init()
        self.setup()
    }
}

// MARK: - BooksTableAdapterInput
extension BooksTableAdapter: BooksTableAdapterInput {
    func reload(with rows: [BooksTableRowType], animated: Bool) {
        self.rows = rows
        guard animated else {
            tableView?.reloadData()
            return
        }
        
        tableView?.reloadSections(.init(integer: .zero), with: .automatic)
    }
}

// MARK: - UITableViewDataSource
extension BooksTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rows[indexPath.row] {
        case let .book(item):
            let cell: BookTableCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setTitle(item.title)
            cell.setAuthor(item.authors.joined(separator: ", "))
            cell.setThumbnailPath(item.smallThumbnail)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension BooksTableAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch rows[indexPath.row] {
        case let .book(item):
            output?.didSelectBook(self, book: item)
        }
    }
}

// MARK: - Private methods
private extension BooksTableAdapter {
    private func setup() {
        guard let tableView = tableView else { return }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset = .init(top: 16.0, left: .zero, bottom: 36.0, right: .zero)
        tableView.separatorStyle = .singleLine

        [BookTableCell.self].forEach(tableView.register(cellClass:))
    }
}
