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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isAccessibilityElement = true
    }
}
