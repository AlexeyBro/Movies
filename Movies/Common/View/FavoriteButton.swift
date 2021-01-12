//
//  FavoriteButton.swift
//  Movies
//
//  Created by Alex Bro on 30.12.2020.
//

import UIKit

protocol FavoriteDelegate {
    func checkItems(forId id: String) -> Bool?
    func addItem(withId id: String)
}

enum StateButton {
    case favorite
    case unfavorite
}

final class FavoriteButton: UIButton {
    
    var delegate: FavoriteDelegate?
    var textLabel = UILabel(text: "favorite", textColor: .white)
    var iconImage = UIImageView(image: UIImage(systemName: "heart"), tintColor: .white)
    var id: String?
    var index: Int?
    var isFavorite: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
        buttonState()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.backgroundColor = .customOrange
        self.layer.cornerRadius = StyleGuide.CornerRadius.single
        self.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
    }
    
    private func makeButton(state: StateButton) {
        switch state {
        case .favorite:
            textLabel.text = "favorite"
            iconImage.image = UIImage(systemName: "heart")
        case .unfavorite:
            textLabel.text = "unfavorite"
            iconImage.image = UIImage(systemName: "heart.slash")
        }
    }
    
    func buttonState() {
        isFavorite = delegate?.checkItems(forId: id ?? "")
        if isFavorite == true {
            makeButton(state: .unfavorite)
        } else {
            makeButton(state: .favorite)
        }
    }
    
    @objc func addFavorite() {
        delegate?.addItem(withId: id ?? "")
        makeButton(state: .unfavorite)
    }
    
    private func setupConstraints() {
        [iconImage, textLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: StyleGuide.Spaces.small),
            iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: StyleGuide.Spaces.small),
            iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -StyleGuide.Spaces.small),
            
            textLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: StyleGuide.Spaces.small),
            textLabel.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -StyleGuide.Spaces.small)
        ])
    }
}
