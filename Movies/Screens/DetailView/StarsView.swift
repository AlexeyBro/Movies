//
//  StarsView.swift
//  Movies
//
//  Created by Alex Bro on 28.12.2020.
//

import UIKit

final class StarsView: UIStackView {
    
    private let maxRating = 5
    private var numderOfStars = 0
    private var starsArray: [UIImageView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        spacing = 5
        semanticContentAttribute = .forceRightToLeft
        distribution = .fillEqually
        makeStars()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func makeRating(rating: Float?) {
        guard let rating = rating else { return }
        for _ in 0..<Int(rating.rounded(.up)) / 2 {
            let starFill = UIImageView(image: UIImage(systemName: "star.fill"), tintColor: .orange)
            addArrangedSubview(starFill)
            numderOfStars += 1
        }

        for _ in numderOfStars..<starsArray.count {
            starsArray.removeLast()
        }

        for star in starsArray {
            removeArrangedSubview(star)
        }
    }

    private func makeStars() {
        for _ in 0..<maxRating {
            let starEmpty = UIImageView(image: UIImage(systemName: "star"), tintColor: .orange)
            addArrangedSubview(starEmpty)
            starsArray.append(starEmpty)
        }
    }
}

