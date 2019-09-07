//
//  PosterController.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import UIKit

fileprivate let imageCache = NSCache<AnyObject, AnyObject>()

class LoadingImageView: UIImageView {
    
    // MARK: - Properties
    
    private var imageURL: URL?
    private let baseURL = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    private let activityIndicator = UIActivityIndicatorView()
    
    /// This function adds an activity controller to the UIImageView and fetches the requested poster image from NSCache if available, else performs a network request
    func loadPoster(for movie: Movie) {
        self.activityIndicator.color = .darkGray
        addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let url = URL.parse("\(self.baseURL)\(movie.posterPath)")
        self.imageURL = url
        self.image = nil
        self.activityIndicator.startAnimating()
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            self.activityIndicator.stopAnimating()
            return
        }
        NetworkController().performRequest(forURL: url, withMethod: .get) { (data, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                return
            }
            DispatchQueue.main.async {
                if let data = data, let fetchedImage = UIImage(data: data) {
                    if self.imageURL == url {
                        self.image = fetchedImage
                    }
                    imageCache.setObject(fetchedImage, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            }
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
