//
//  BookDetailInteractor.swift
//  BookSearcher
//
//  Created by Arman Turalin on 02.03.2022.
//

import Foundation

protocol BookDetailInteractorOutputProtocol: AnyObject {
}

protocol BookDetailInteractorInputProtocol {
}

final class BookDetailInteractor: BaseInteractor {
    weak var output: BookDetailInteractorOutputProtocol? {
        didSet { basePresenter = output as? BasePresenter }
    }
}

// MARK: - BookDetailInteractorInputProtocol
extension BookDetailInteractor: BookDetailInteractorInputProtocol {
}

// MARK: - Private methods
private extension BookDetailInteractor {
}
