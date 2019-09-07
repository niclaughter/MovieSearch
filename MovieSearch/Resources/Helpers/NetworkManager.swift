//
//  NetworkManager.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import Foundation

class NetworkController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    /**
     Builds a request and starts a data task with URLSession. Used to make network calls.
     * NOTICE: If a full URL with parameters is passed in, everything following and including
     the ? will be removed. Be sure to include parameters in the urlParameters parameter.
     
     - Parameter url: the URL to use for the network call
     - Parameter httpMethod: the httpMethod to use (get, put, post, patch, delete)
     - Parameter urlParameters: the parameters to send with the network call
     - Parameter body: the body to send with the call
     - Parameter completion: the completion block to call
     */
    func performRequest(forURL url: URL,
                        withMethod httpMethod: HTTPMethod,
                        urlHeaders: [String: String]? = nil,
                        urlParameters: [String: String]? = nil,
                        body: Data? = nil,
                        completion: ((Data?, Error?) -> Void)? = nil) {
        let requestURL = getURL(byAddingParameters: urlParameters, toURL: url)
        var request = URLRequest(url: requestURL)
        urlHeaders?.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            completion?(data, error)
        }
        dataTask.resume()
    }
    
    /**
     Builds the final URL to use in the network call by adding the parameters in the appropriate format to the end of
     the base URL
     * NOTICE: If a full URL with parameters is passed in to
     performRequest(forURL:withMethod:urlHeaders:urlParameters:body:completion:), everything following and including
     the ? will be removed. Be sure to include parameters in the urlParameters parameter above.
     - Parameter parameters: the parameters to add to the base URL
     - Returns: returns the base URL if it was not successful, or the new URL if it was.
     */
    private func getURL(byAddingParameters parameters: [String: String]?, toURL url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        guard let url = components?.url else { fatalError("URL is nil") }
        return url
    }
}

