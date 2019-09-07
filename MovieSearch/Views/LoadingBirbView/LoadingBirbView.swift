//
//  LoadingBirbView.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import UIKit

// I know this is a ridiculously-nameed class, I absolutely wouldn't try to be humorous like this in my actual job.

@IBDesignable
class LoadingBirbView: UIView, DesignableNib {
    
    // MARK: - Outlets
    
    @IBOutlet var birbBackingView: UIView!
    @IBOutlet var birbImageView: UIImageView!
    
    // MARK: - Properties
    
    public static var nibName: String = "LoadingBirbView"
    
    // MARK: - Super class overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupFromNib()
    }
    
    // MARK: - Helper functions
    
    func animate() {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.birbBackingView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self?.birbImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
                UIView.animate(withDuration: 1, animations: { [weak self] in
                    self?.alpha = 0
                    self?.birbBackingView.transform = CGAffineTransform(scaleX: 200, y: 200)
                    self?.birbImageView.transform = CGAffineTransform(scaleX: 200, y: 200)
                    }, completion: { [weak self] _ in
                        self?.removeFromSuperview()
                })
        })
    }
}
