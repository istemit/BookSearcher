//
//  BooksInteractor.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import Foundation

protocol BooksInteractorOutputProtocol: AnyObject {
    func didFetchBooks(_ books: [String])
}

protocol BooksInteractorInputProtocol {
    func fetchBooks()
}

final class BooksInteractor: BaseInteractor {
    weak var output: BooksInteractorOutputProtocol? {
        didSet { basePresenter = output as? BasePresenter }
    }

//    init() {
//        // TODO: - Add dependencies
//    }
}

// MARK: - BooksInteractorInputProtocol
extension BooksInteractor: BooksInteractorInputProtocol {
    func fetchBooks() {
        output?.didFetchBooks([])
    }
}

// MARK: - Private methods
private extension BooksInteractor {
}
