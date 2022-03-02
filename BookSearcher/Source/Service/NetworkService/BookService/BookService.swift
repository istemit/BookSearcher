//
//  BookService.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import Foundation

protocol BookServiceProtocol {
    func getBooks(by query: String, completion: @escaping (_ result: Result<[BookEntity], BaseNetworkError>) -> Void)
}

final class BookService: BookServiceProtocol {

    private let provider: BaseNetwork<BookTarget>
    
    init(provider: BaseNetwork<BookTarget>) {
        self.provider = provider
    }
    
    func getBooks(by query: String, completion: @escaping (_ result: Result<[BookEntity], BaseNetworkError>) -> Void) {
        provider.request(with: .getBooks(query: query)) { data, error in
            guard let data = data else {
                if let error = error { completion(.failure(error)) }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(BooksResponseRaw.self, from: data)
                let entities = response.items.map { BookEntity.Builder.build(from: $0) }
                completion(.success(entities))
            } catch _ {
                completion(.failure(.wrongResponseError))
            }
        }
    }
}
