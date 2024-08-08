//
//  CreatorModel.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import Foundation

struct Creator: Codable {
    let id: Int
    let firstName: String?
    let middleName: String?
    let lastName: String?
    let suffix: String?
    let fullName: String?
    let modified: String?
    let resourceURI: String?
    let urls: [URLInfo]?
    let thumbnail: Thumbnail
    let series: Series
    let stories: Stories
    let comics: Comics
    let events: Events
    
    var imageURL: URL? {
        URL(string: "\(thumbnail.path).\(thumbnail.extension)")
    }

    struct URLInfo: Codable {
        let type: String
        let url: String
    }

    struct Thumbnail: Codable {
        let path: String
        let `extension`: String
    }

    struct Series: Codable {
        let available: Int
        let returned: Int
        let collectionURI: String
        let items: [SeriesItem]

        struct SeriesItem: Codable {
            let resourceURI: String
            let name: String
        }
    }

    struct Stories: Codable {
        let available: Int
        let returned: Int
        let collectionURI: String
        let items: [StoryItem]

        struct StoryItem: Codable {
            let resourceURI: String
            let name: String
            let type: String
        }
    }

    struct Comics: Codable {
        let available: Int
        let returned: Int
        let collectionURI: String
        let items: [ComicItem]

        struct ComicItem: Codable {
            let resourceURI: String
            let name: String
        }
    }

    struct Events: Codable {
        let available: Int
        let returned: Int
        let collectionURI: String
        let items: [EventItem]

        struct EventItem: Codable {
            let resourceURI: String
            let name: String
        }
    }
}
