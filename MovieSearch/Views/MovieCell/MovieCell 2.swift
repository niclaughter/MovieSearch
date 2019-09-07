//
//  MovieCell.swift
//  MovieSearch
//
//  Created by Nicholas Laughter on 7/18/19.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()

        self.addLoadingIndicator()
    }

    private func addLoadingIndicator() {

    }
}
