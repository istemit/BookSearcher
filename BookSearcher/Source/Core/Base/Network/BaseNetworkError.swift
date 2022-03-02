//
//  BaseNetworkError.swift
//  BookSearcher
//
//  Created by Arman Turalin on 02.03.2022.
//

import Foundation

enum BaseNetworkError: Error {
    case clientSideError
    case serverSideError(code: Int)
    case connectionError
    case wrongResponseError
    case timeoutError
    case notConnectedToInternetError
}
