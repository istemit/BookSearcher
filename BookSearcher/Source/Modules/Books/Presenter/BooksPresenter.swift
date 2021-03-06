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
    
    private var searchText: String = ""
    private var books: [BookEntity] = []
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
        
    func viewDidSelectBook(_ book: BookEntity) {
        router.showBooksDetailScreen(with: book)
    }
    
    func viewDidEndSearching(_ text: String) {
        guard searchText != text else { return }
        searchText = text
        guard !text.isEmpty else { return }
        interactor.fetchBooks(by: text)
    }
}

// MARK: - BooksInteractorOutputProtocol
extension BooksPresenter: BooksInteractorOutputProtocol {
    func didFetchBooks(_ books: [BookEntity]) {
        guard self.books != books else { return }
        self.books = books
        configureRows()
    }
    
    func didFailToFetchBooks() {
        // TODO: - Add notification to show error
    }
}

// MARK: - BooksRouterOutputProtocol
extension BooksPresenter: BooksRouterOutputProtocol {
}

// MARK: - BookDetailModuleOutputProtocol
extension BooksPresenter: BookDetailModuleOutputProtocol {
}

// MARK: - Private methods
private extension BooksPresenter {
    func configureRows() {
        self.rows = books.map { .book(item: $0) }
        view?.reload(with: rows, animated: true)
    }
}
