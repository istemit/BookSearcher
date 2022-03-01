//
//  BooksPresenter.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

protocol BooksModuleOutputProtocol: AnyObject {
}

protocol BooksModuleInputProtocol {
    func configureModule(output: BooksModuleOutputProtocol)
}

final class BooksPresenter: BasePresenter {
    weak var output: BooksModuleOutputProtocol?

    private weak var view: BooksViewInputProtocol?
    private let interactor: BooksInteractorInputProtocol
    private let router: BooksRouterInputProtocol
    
    private var rows: [BooksTableRowType] = []
    
    init(view: BooksViewInputProtocol,
         interactor: BooksInteractorInputProtocol,
         router: BooksRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        super.init(interactor: interactor as? BaseInteractor, router: router as? BaseRouter, viewController: view as? BaseViewController)
    }
}

// MARK: - BooksModuleInputProtocol
extension BooksPresenter: BooksModuleInputProtocol {
    func configureModule(output: BooksModuleOutputProtocol) {
        self.output = output
    }
}

// MARK: - BooksViewOutputProtocol
extension BooksPresenter: BooksViewOutputProtocol {
    func viewDidLoad() {
        view?.setupView()
    }
    
    func viewDidDisappear() {
    }
    
    func viewWillAppear() {
    }
    
    func viewDidSelectBook(_ book: String) {
    }
}

// MARK: - BooksInteractorOutputProtocol
extension BooksPresenter: BooksInteractorOutputProtocol {
    func didFetchBooks(_ books: [String]) {
    }
}

// MARK: - BooksRouterOutputProtocol
extension BooksPresenter: BooksRouterOutputProtocol {
}

// MARK: - Private methods
private extension BooksPresenter {
    func configureRows() {
    }
}
