//
//  CharacterModel.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: MarvelImage

    var imageURL: URL? {
        URL(string: "\(thumbnail.path).\(thumbnail.extension)")
    }
}
