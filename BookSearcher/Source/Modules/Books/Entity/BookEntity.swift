//
//  BookEntity.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import Foundation

struct BookEntity {
    let id: String
    let title: String
    let authors: [String]
    let description: String
    let smallThumbnail: String
    let thumbnail: String
}

// MARK: - Builder
extension BookEntity {
    enum Builder {
        static func build(from raw: BookRaw) -> BookEntity {
            return BookEntity(id: raw.id,
                              title: raw.volumeInfo?.title ?? "",
                              authors: raw.volumeInfo?.authors ?? [],
                              description: raw.volumeInfo?.description ?? "",
                              smallThumbnail: raw.volumeInfo?.imageLinks?.smallThumbnail ?? "",
                              thumbnail: raw.volumeInfo?.imageLinks?.thumbnail ?? "")
        }
    }
}
