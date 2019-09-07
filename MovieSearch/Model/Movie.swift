//
//  Movie.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    // MARK: - Properties
    
    let title: String
    let overview: String
    let posterPath: String
    
    // MARK: - Initializers
    
    init?(_ json: JSONDictionary) {
        guard let title = json["title"] as? String,
            let overview = json["overview"] as? String,
            let posterPath = json["poster_path"] as? String else { return nil }
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
    }
}
