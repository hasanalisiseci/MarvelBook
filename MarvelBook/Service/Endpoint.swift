//
//  Endpoint.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import Foundation

enum Endpoint {
    case characters
    case comics
    case creators(creatorId: Int)
    case events(characterId: Int)

    var path: String {
        switch self {
        case .characters:
            return "/characters"
        case .comics:
            return "/comics"
        case let .creators(creatorId):
            return "/creators/\(creatorId)"
        case let .events(characterId):
            return "/characters/\(characterId)/events"
        }
    }

    var params: [String: String] {
        switch self {
        case .characters, .comics, .creators, .events:
            return [:]
        }
    }
}
