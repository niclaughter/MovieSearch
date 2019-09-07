//
//  MovieListContainerViewController.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import UIKit

// I didn't love how I implemented the splash animation and header. If I had more time I would have done more research on how Twitter is doing the splash, but this will hve to do.

class MovieListContainerViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var loadingBirbView: LoadingBirbView!
    
    // MARK: - Super Class Overrides
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        perform(#selector(animateBirbView), with: nil, afterDelay: 0.75)
    }
    
    // MARK: - Helper Methods
    
    @objc
    func animateBirbView() {
        self.loadingBirbView.animate()
    }
}
