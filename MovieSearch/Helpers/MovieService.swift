//
//  MovieService.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import Foundation

class MovieService {
    
    // MARK: - Properties
    
    // Normally I would put these somewhere more centralized and taken the time to name them more appropriately
    private var baseURL = "https://api.themoviedb.org/3/search/movie"
    private var queryParameterKey = "query"
    private var apiKeyParameterKey = "api_key"
    private var tokenParameterKey = "2a61185ef6a27f400fd92820ad9e8537"
    
    // MARK: - CRUD operations
    
    func fetchMovies(with query: String, completion: @escaping (Result<[Movie], APIServiceError>) -> Void) {
        guard let url = URL(string: self.baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        let parameters = [
            self.queryParameterKey: query,
            self.apiKeyParameterKey: self.tokenParameterKey
        ]
        APIService().getResources(url: url, urlParameters: parameters) { (result: Result<Data, APIServiceError>) in
            switch result {
            case .success(let data):
                do {
                    let moviePage = try JSONDecoder().decode(MoviePage.self, from: data)
                    completion(.success(moviePage.movies))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

