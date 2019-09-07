//
//  MovieController.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import Foundation

class MovieController {
    
    // MARK: - Properties
    
    // Normally I would put these somewhere more centralized and taken the time to name them more appropriately
    private var baseURL = "https://api.themoviedb.org/3/search/movie"
    private var queryParameterKey = "query"
    private var apiKeyParameterKey = "api_key"
    private var tokenParameterKey = "2a61185ef6a27f400fd92820ad9e8537"
    
    // MARK: - CRUD operations
    
    func fetchMovies(with query: String, completion: @escaping ([Movie]) -> Void) {
        NetworkController().performRequest(forURL: URL.parse(self.baseURL),
                                           withMethod: .get,
                                           urlParameters: [self.queryParameterKey: query,
                                                           self.apiKeyParameterKey: self.tokenParameterKey],
                                           completion: { (data, error) in
            // I would of course do more interactive error handling here if I had more time
            if let error = error {
                // I like NSLog over print for the timestamp
                NSLog(error.localizedDescription)
                completion([])
            }

            guard let data = data,
                let response = try? JSONSerialization.jsonObject(with: data) as? JSONDictionary,
                let movieDictionaries = response["results"] as? MovieDataDictionaries else { return completion([]) }
                completion(movieDictionaries.compactMap { Movie($0) })
        })
    }
}

