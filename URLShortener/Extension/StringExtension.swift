//
//  StringExtension.swift
//  URLShortenerApp
//
//  Created by PiPyL on 1/20/20.
//  Copyright © 2020 PiPyL. All rights reserved.
//

import UIKit

extension String {
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    func getUnderLineAttributedText() -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}
