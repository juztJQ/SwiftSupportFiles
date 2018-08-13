//
//  String.swift
//  Kotex Puma
//
//  Created by Juan Quiroga on 25/08/17.
//  Copyright © 2017 Juan Quiroga. All rights reserved.
//

import Foundation

extension String {
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
}
