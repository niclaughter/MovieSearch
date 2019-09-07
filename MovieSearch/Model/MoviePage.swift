//
//  MoviePage.swift
//  MovieSearch
//
//  Created by Nicholas Laughter on 9/6/19.
//  Copyright © 2019 Twitter. All rights reserved.
//

import Foundation

struct MoviePage: Decodable {

    let page: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        movies = try container.decode([Movie].self, forKey: .movies)
    }
}
