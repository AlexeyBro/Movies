//
//  UIButton.swift
//  Movies
//
//  Created by Alex Bro on 21.12.2020.
//

import UIKit

enum ButtonStyle {
    case navBar
    case contacts
}

extension UIButton {
    
    convenience init(image: UIImage?, tintColor: UIColor, backgroundColor: UIColor) {
        self.init()
        
        self.setImage(image, for: .normal)
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
    }
    
    func setImage(named: String, style: ButtonStyle) {
        let image = UIImageView(image: UIImage(systemName: named),
                                tintColor: .customOrange)
        image.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(image)
        
        switch style {
        case .navBar:
            NSLayoutConstraint.activate([
                image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                image.topAnchor.constraint(equalTo: self.topAnchor),
                image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                image.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        case .contacts:
            NSLayoutConstraint.activate([
                image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                image.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
        }
    }
}
