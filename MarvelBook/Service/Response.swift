//
//  Response.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import Foundation

struct MarvelResponse<T: Decodable>: Decodable {
    let code: Int
    let status: String
    let data: MarvelDataContainer<T>
}

struct MarvelDataContainer<T: Decodable>: Decodable {
    let results: [T]
}
