//
//  BooksInteractor.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import Foundation

protocol BooksInteractorOutputProtocol: AnyObject {
    func didFetchBooks(_ books: [BookEntity])
    func didFailToFetchBooks()
}

protocol BooksInteractorInputProtocol {
    func fetchBooks(by query: String)
}

final class BooksInteractor: BaseInteractor {
    weak var output: BooksInteractorOutputProtocol? {
        didSet { basePresenter = output as? BasePresenter }
    }
    
    private let bookService: BookServiceProtocol

    init(bookService: BookServiceProtocol) {
        self.bookService = bookService
    }
}

// MARK: - BooksInteractorInputProtocol
extension BooksInteractor: BooksInteractorInputProtocol {
    func fetchBooks(by query: String) {
        bookService.getBooks(by: query) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(items):
                    self.output?.didFetchBooks(items)
                case .failure:
                    self.output?.didFailToFetchBooks()
                    // TODO: - Add error handler
                }
            }
        }
    }
}

// MARK: - Private methods
private extension BooksInteractor {
}
