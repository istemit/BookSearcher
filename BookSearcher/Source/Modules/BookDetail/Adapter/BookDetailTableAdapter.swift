//
//  BookDetailTableAdapter.swift
//  BookSearcher
//
//  Created by Arman Turalin on 02.03.2022.
//

import UIKit

enum BookDetailTableRowType {
    case thumbnail(path: String)
    case info(book: BookEntity)
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
        case let .thumbnail(path):
            let cell: BookDetailImageTableCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setThumnailPath(path)
            return cell
        case let .info(item):
            let cell: BookDetailDescriptionTableCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setTitle(item.title)
            cell.setAuthor(item.authors.joined(separator: ", "))
            cell.setDescription(item.description)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension BookDetailTableAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch rows[indexPath.row] {
        case .thumbnail:
            return UIScreen.main.bounds.width * 0.7
        case .info:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - Private methods
private extension BookDetailTableAdapter {
    private func setup() {
        guard let tableView = tableView else { return }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear // TODO: - Add color manager

        [BookDetailImageTableCell.self, BookDetailDescriptionTableCell.self].forEach(tableView.register(cellClass:))
    }
}
