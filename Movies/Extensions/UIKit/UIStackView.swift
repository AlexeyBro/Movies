//
//  UIStackView.swift
//  Movies
//
//  Created by Alex Bro on 21.12.2020.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis = .horizontal,
                     spacing: CGFloat,
                     semanticContentAttribute: UISemanticContentAttribute = .unspecified) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.spacing = spacing
        self.semanticContentAttribute = semanticContentAttribute
    }
}
