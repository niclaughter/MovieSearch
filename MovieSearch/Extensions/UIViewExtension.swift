//
//  UIViewExtension.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import UIKit

private protocol DesignableNib {
    static var nibName: String { get }
}

extension UIView: DesignableNib {
    
    static var nibName: String {
        return String(describing: Self.self) // defaults to the name of the class implementing this protocol.
    }
    
    static var nib: UINib {
        let bundle = Bundle(for: Self.self)
        return UINib(nibName: Self.nibName, bundle: bundle)
    }
    
    /// Loads the nib during the init of a view (so you can use a xib in a storyboard)
    /// - Example:
    /// ````
    /// required init?(coder aDecoder: NSCoder) {
    ///   super.init(coder: aDecoder)
    /// 
    ///   setupFromNib()
    /// }
    ///
    /// override init(frame: CGRect) {
    ///     super.init(frame: frame)
    ///
    ///     setupFromNib()
    /// }
    /// ````
    func setupFromNib() {
        let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            view.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
            view.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
            view.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
            view.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        }
    }
}

/// Load a nib (the name of the class must match the name of the xib)
public func loadNib<T: UIView>(name: String? = nil) -> T {
    let nib = UINib(nibName: name ?? String(describing: T.self), bundle: Bundle(for: T.self))
    return nib.instantiate(withOwner: nil, options: nil).first! as! T
}
