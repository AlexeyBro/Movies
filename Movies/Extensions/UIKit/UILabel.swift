//
//  UILabel.swift
//  Movies
//
//  Created by Alex Bro on 21.12.2020.
//

import UIKit

extension UILabel {
    
    convenience init(text: String? = nil,
                     textColor: UIColor = .white,
                     font: UIFont? = nil,
                     textAlignment: NSTextAlignment = .natural) {
        self.init()
        
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }
}
