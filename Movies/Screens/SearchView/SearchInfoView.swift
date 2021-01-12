//
//  SearchInfoView.swift
//  Movies
//
//  Created by Alex Bro on 30.12.2020.
//

import UIKit

enum Style {
    case initial
    case error
}

final class SearchInfoView: UIView {
    
    private var iconImage = UIImageView(tintColor: .lightBeige)
    private var infoLabel = UILabel(textColor: .lightBeige, font: .defaultBold22, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settings(style: Style) {
        switch style {
        case .initial:
            iconImage.image = UIImage(systemName: "magnifyingglass")
            infoLabel.text = "Enter the title of the movie"
        case .error:
            iconImage.image = UIImage(systemName: "xmark.octagon")
            infoLabel.text = "Movie with that name\n was not found"
            infoLabel.numberOfLines = 0
        }
    }
    
    private func setupConstraints() {
        [iconImage, infoLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: self.topAnchor),
            iconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 100),
            iconImage.heightAnchor.constraint(equalToConstant: 100),
            
            infoLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: StyleGuide.Spaces.double),
            infoLabel.centerXAnchor.constraint(equalTo: iconImage.centerXAnchor)
        ])
    }
}
