//
//  ComicModel.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import Foundation

struct Comic: Decodable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: MarvelImage
    let prices: [ComicPrice]
    let creators: CreatorsOfComics

    var imageURL: URL? {
        URL(string: "\(thumbnail.path).\(thumbnail.extension)")
    }

    var comicPrice: String {
        guard let price = prices.first?.price else { return "-" }
        return "\(price)$"
    }
}

struct CreatorsOfComics: Codable {
    let available: Int
    let collectionURI: String
    let items: [Creators]
    let returned: Int
}

struct Creators: Codable {
    let resourceURI: String
    let name: String
    let role: String

    var id: Int? {
        let components = resourceURI.split(separator: "/")
        guard let lastComponent = components.last, let id = Int(lastComponent) else {
            return nil
        }
        return id
    }
}
