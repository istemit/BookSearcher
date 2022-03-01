//
//  BooksRouter.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

protocol BooksRouterOutputProtocol: AnyObject {
}

protocol BooksRouterInputProtocol {
    func showBooksDetailScreen()
}

final class BooksRouter: BaseRouter {
    weak var output: BooksRouterOutputProtocol? {
        didSet { basePresenter = output as? BasePresenter }
    }
}

// MARK: - BooksRouterInputProtocol
extension BooksRouter: BooksRouterInputProtocol {
    func showBooksDetailScreen() {
        
    }
}

// MARK: - Private methods
private extension BooksRouter {
}
