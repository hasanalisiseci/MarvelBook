//
//  OtherMarvelModels.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import Foundation

struct Series: Decodable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: MarvelImage
}

struct Event: Decodable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: MarvelImage
}

struct ComicPrice: Codable {
    let type: String
    let price: Double
}

struct MarvelImage: Decodable {
    let path: String
    let `extension`: String
}
