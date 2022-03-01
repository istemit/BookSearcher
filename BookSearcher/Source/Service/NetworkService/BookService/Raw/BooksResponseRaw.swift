//
//  BooksResponseRaw.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import Foundation

struct BooksResponseRaw: Codable {
    let items: [BookRaw]
}
