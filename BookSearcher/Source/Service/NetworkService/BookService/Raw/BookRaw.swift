//
//  BookRaw.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import Foundation

struct BookRaw: Codable {
    struct VolumeInfoRaw: Codable {
        struct ImageLinksRaw: Codable {
            let smallThumbnail: String
            let thumbnail: String
        }
        
        let title: String?
        let authors: [String]?
        let description: String?
        let imageLinks: ImageLinksRaw?
    }

    let id: String
    let volumeInfo: VolumeInfoRaw?
}

