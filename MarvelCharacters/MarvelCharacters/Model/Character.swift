//
//  Character.swift
//  MarvelCharacters
//
//  Created by ali rahal on 13/07/2023.
//

import Foundation

struct CharactersResponse: Codable {

    let data: CharactersDataResponse

    struct CharactersDataResponse: Codable {
        let results: [MarvelResult]
        let offset: Int
        let limit: Int
        let total: Int  //The total number of resources available given the current filter set.
    }
}
// MARK: - Result
struct MarvelResult: Codable {
    let id: Int
    let name, description: String
    let thumbnail: Thumbnail
    let urls: [URLElement]
}



// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    var completeURL: URL? {
        return URL(string: path + "." + self.thumbnailExtension)
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String
    let url: String
}
