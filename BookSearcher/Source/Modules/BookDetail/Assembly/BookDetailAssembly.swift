//
//  BookDetailAssembly.swift
//  BookSearcher
//
//  Created by Arman Turalin on 02.03.2022.
//

import Foundation

final class BookDetailAssembly: BaseAssembly {
    func makeModule() -> AssembledScreen<BookDetailModuleInputProtocol> {
        let interactor = BookDetailInteractor()
        let viewController = BookDetailViewController()
        let router = BookDetailRouter(viewController: viewController)
        let presenter = BookDetailPresenter(view: viewController, interactor: interactor, router: router)
        
        viewController.output = presenter
        interactor.output = presenter
        router.output = presenter

        return AssembledScreen(input: presenter, viewController: viewController)
    }
}
