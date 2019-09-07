//
//  MovieCell.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var posterImageView: LoadingImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!

    public func configure(movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        if let poster = movie.posterPath,
            let url = URL(string: "\(MovieService.basePosterURL)\(poster)") {
            posterImageView.load(url: url)
        } else {
            // TODO: add placeholder image per challenge instructions
            posterImageView.image = nil
        }

        isAccessibilityElement = true
        accessibilityLabel = movie.title
        accessibilityHint = movie.overview
    }
}
