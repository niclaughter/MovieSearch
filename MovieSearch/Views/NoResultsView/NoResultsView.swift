//
//  NoResultsView.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import UIKit

// Even though I'm not utilizing any of the designable tools here, I'm simply adopting this protocol for simplicity of using the nib.

class NoResultsView: UIView, DesignableNib {
    
    // MARK: - Properties
    
    public static var nibName: String = "NoResultsView"
    
    // MARK: - Super class overrides

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupFromNib()
    }
}
