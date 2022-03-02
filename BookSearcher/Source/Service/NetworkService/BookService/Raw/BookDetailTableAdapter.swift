//
//  BookDetailTableAdapter.swift
//  BookSearcher
//
//  Created by Arman Turalin on 02.03.2022.
//

import UIKit

enum BookDetailTableRowType {
    case book(item: BookEntity)
}

protocol BookDetailTableAdapterOutput: AnyObject {
}

protocol BookDetailTableAdapterInput {
    func reload(with rows: [BookDetailTableRowType], animated: Bool)
}

final class BookDetailTableAdapter: NSObject {
    private weak var output: BookDetailTableAdapterOutput?
    private let tableView: UITableView?
    
    private var rows: [BookDetailTableRowType] = []

    init(tableView: UITableView, output: BookDetailTableAdapterOutput) {
        self.tableView = tableView
        self.output = output
        super.init()
        self.setup()
    }
}

// MARK: - BookDetailTableAdapterInput
extension BookDetailTableAdapter: BookDetailTableAdapterInput {
    func reload(with rows: [BookDetailTableRowType], animated: Bool) {
        self.rows = rows
        guard animated else {
            tableView?.reloadData()
            return
        }
        
        tableView?.reloadSections(.init(integer: .zero), with: .automatic)
    }
}

// MARK: - UITableViewDataSource
extension BookDetailTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rows[indexPath.row] {
        case let .book(item):
            let cell: BookTableCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setTitle(item.title)
            cell.setAuthor(item.authors.joined(separator: ", "))
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension BookDetailTableAdapter: UITableViewDelegate {
}

// MARK: - Private methods
private extension BookDetailTableAdapter {
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
