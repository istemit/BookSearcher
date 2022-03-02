//
//  BookDetailPresenter.swift
//  BookSearcher
//
//  Created by Arman Turalin on 02.03.2022.
//

import UIKit

protocol BookDetailModuleOutputProtocol: AnyObject {
}

protocol BookDetailModuleInputProtocol {
    func configureModule(output: BookDetailModuleOutputProtocol, book: BookEntity)
}

final class BookDetailPresenter: BasePresenter {
    weak var output: BookDetailModuleOutputProtocol?

    private weak var view: BookDetailViewInputProtocol?
    private let interactor: BookDetailInteractorInputProtocol
    private let router: BookDetailRouterInputProtocol
    
    private var book: BookEntity?
    private var rows: [BookDetailTableRowType] = []
    
    init(view: BookDetailViewInputProtocol,
         interactor: BookDetailInteractorInputProtocol,
         router: BookDetailRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        super.init(interactor: interactor as? BaseInteractor, router: router as? BaseRouter, viewController: view as? BaseViewController)
    }
}

// MARK: - BookDetailModuleInputProtocol
extension BookDetailPresenter: BookDetailModuleInputProtocol {
    func configureModule(output: BookDetailModuleOutputProtocol, book: BookEntity) {
        self.output = output
        self.book = book
    }
}

// MARK: - BookDetailViewOutputProtocol
extension BookDetailPresenter: BookDetailViewOutputProtocol {
    func viewDidLoad() {
        view?.setupView()
        view?.updateTitle(book?.title ?? "")
    }
}

// MARK: - BookDetailInteractorOutputProtocol
extension BookDetailPresenter: BookDetailInteractorOutputProtocol {
}

// MARK: - BookDetailRouterOutputProtocol
extension BookDetailPresenter: BookDetailRouterOutputProtocol {
}

// MARK: - Private methods
private extension BookDetailPresenter {
    func configureRows() {
        guard let book = book else { return }
        
//        self.rows = books.map { .book(item: $0) }
        view?.reload(with: rows, animated: true)
    }
}
