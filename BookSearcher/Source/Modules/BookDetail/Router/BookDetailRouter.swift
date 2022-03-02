//
//  BookDetailRouter.swift
//  BookSearcher
//
//  Created by Arman Turalin on 02.03.2022.
//

import UIKit

protocol BookDetailRouterOutputProtocol: AnyObject {
}

protocol BookDetailRouterInputProtocol {
}

final class BookDetailRouter: BaseRouter {
    weak var output: BookDetailRouterOutputProtocol? {
        didSet { basePresenter = output as? BasePresenter }
    }
}

// MARK: - BooksRouterInputProtocol
extension BookDetailRouter: BookDetailRouterInputProtocol {
}

// MARK: - Private methods
private extension BookDetailRouter {
}
