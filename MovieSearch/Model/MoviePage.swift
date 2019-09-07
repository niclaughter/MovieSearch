//
//  MoviePage.swift
//  MovieSearch
//
//  Created by Nicholas Laughter on 9/6/19.
//  Copyright © 2019 Twitter. All rights reserved.
//

import Foundation

struct MoviePage: Codable {

    let page: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
    }
    
}
