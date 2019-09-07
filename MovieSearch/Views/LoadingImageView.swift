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
        guard let url = URL(string: "\(self.baseURL)\(movie.posterPath)") else { return }

        self.activityIndicator.color = .darkGray
        addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        self.imageURL = url
        self.image = nil
        self.activityIndicator.startAnimating()
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            self.activityIndicator.stopAnimating()
            return
        }
        APIService().getResources(url: url) { [weak self] (result: Result<Data, APIServiceError>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(let imageData):
                        guard let self = self,
                            let image = UIImage(data: imageData) else { return }
                        self.image = image
                        imageCache.setObject(image, forKey: url as AnyObject)
                    case .failure(let error):
                        print(error)
                }
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}
