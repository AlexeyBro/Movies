//
//  UITextView.swift
//  Movies
//
//  Created by Alex Bro on 28.12.2020.
//

import UIKit

extension UITextView {
    
    convenience init(backgroundColor: UIColor,
                     textColor: UIColor,
                     font: UIFont,
                     textAlignment: NSTextAlignment = .justified) {
        self.init()
        
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }
}
