//
//  BookTarget.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import Foundation

enum BookTarget {
    case getBooks(query: String)
}

extension BookTarget: BaseTarget {
    var path: String {
        switch self {
        case let .getBooks(query):
            return "/books/v1/volumes?q=" + query
        }
    }

    var method: HttpMethod {
        switch self {
        case .getBooks:
            return .get
        }
    }
}
