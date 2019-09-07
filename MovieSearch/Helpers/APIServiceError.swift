//
//  APIServiceError.swift
//  MovieSearch
//
//  Created by Nicholas Laughter on 9/6/19.
//  Copyright © 2019 Twitter. All rights reserved.
//

public enum APIServiceError: Error {
    case apiError
    case invalidURL
    case invalidResponse
    case noData
    case decodeError
}
