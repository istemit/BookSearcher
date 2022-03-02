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
    func showBooksDetailScreen(with book: BookEntity)
}

final class BooksRouter: BaseRouter {
    weak var output: BooksRouterOutputProtocol? {
        didSet { basePresenter = output as? BasePresenter }
    }
}

// MARK: - BooksRouterInputProtocol
extension BooksRouter: BooksRouterInputProtocol {
    func showBooksDetailScreen(with book: BookEntity) {
        guard let moduleOutput = output as? BookDetailModuleOutputProtocol else { return }
        let module = BookDetailAssembly().makeModule()
        module.input.configureModule(output: moduleOutput, book: book)
        viewController?.navigationController?.pushViewController(module.viewController, animated: true)
    }
}

// MARK: - Private methods
private extension BooksRouter {
}
