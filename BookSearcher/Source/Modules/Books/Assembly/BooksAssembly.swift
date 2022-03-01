//
//  BooksAssembly.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

final class BooksAssembly: BaseAssembly {
    func makeModule() -> AssembledScreen<BooksModuleInputProtocol> {
        let bookService = BookService(provider: BaseNetwork<BookTarget>())
        let interactor = BooksInteractor(bookService: bookService)
        let viewController = BooksViewController()
        let router = BooksRouter(viewController: viewController)
        let presenter = BooksPresenter(view: viewController, interactor: interactor, router: router)
        
        viewController.output = presenter
        interactor.output = presenter
        
        return AssembledScreen(input: presenter, viewController: viewController)
    }
}
