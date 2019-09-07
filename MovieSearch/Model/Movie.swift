//
//  Movie.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import Foundation

struct Movie: Codable {

    // TODO: marks are good, but not always necessary.
    // especially on simple structs, the marks not necessary and don't add any value

    // MARK: - Properties
    
    let title: String
    let overview: String
    let posterPath: String?

    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
    }

    //TODO: discuss inititalizers. They are not necessary when using Codable
    
}
