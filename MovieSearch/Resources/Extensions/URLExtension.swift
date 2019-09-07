//
//  URLExtension.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import Foundation

// This is a little snippet I like to use, though admittedly it sort of defeats the safety features of optionals in this case. 
extension URL {
    
    /// Returns the URL from the string, or an empty url if the parsing fails
    static func parse(_ string: String) -> URL {
        return self.init(string: string) ?? URL(string: "https://")!
    }
}
