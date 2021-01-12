//
//  DetailView.swift
//  Movies
//
//  Created by Alex Bro on 22.12.2020.
//

import UIKit

final class DetailView: UIView {
    
    var backdropImage = UIImageView()
    let runtimeLabel = UILabel(textColor: .darkBlue, font: .default18)
    let titleLabel = UILabel(textColor: .customOrange, font: .defaultBold24, textAlignment: .center)
    let starsView = StarsView()
    let genreLabel = UILabel(textColor: .darkBlue, font: .default16)
    let directorsLabel = UILabel(textColor: .darkBlue, font: .default16)
    let starsLabel = UILabel(textColor: .darkBlue, font: .default16)
    let plotTextView = UITextView(backgroundColor: .beige, textColor: .darkBlue, font: .default16, textAlignment: .justified)
    private let genreHeading = UILabel(text: "Genre", textColor: .customOrange, font: .default16, textAlignment: .right)
    private let directorsHeading = UILabel(text: "Directors", textColor: .customOrange, font: .default16, textAlignment: .right)
    private let starsHeading = UILabel(text: "Stars", textColor: .customOrange, font: .default16, textAlignment: .right)
    private let separator = UIView()
    private var rating: Float?
    private var path = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .beige
        self.layer.cornerRadius = 10
        setupNumberOfLine()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
        setupConstraints()
        setupSeparator()
    }

    private func setupNumberOfLine() {
        [titleLabel, genreLabel, directorsLabel, starsLabel].forEach {
            $0.numberOfLines = 3
        }
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.sizeToFit()
    }
    
    private func setupSeparator() {
        separator.createDottedLine(width: 3, color: .lightBeige)
    }
    
    private func overLay(size: CGSize, points: CGPoint) {
        let size = size
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: points, size: size))
        path.append(circlePath)
        
        let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
            self.layer.mask = maskLayer
    }
    
    private func updateUI() {
        path = UIBezierPath(rect: self.bounds)
        let viewFrames = self.bounds
        let cornerSize = CGSize(width: 40, height: 40)
        let centerSize = CGSize(width: 60, height: 60)
        overLay(size: cornerSize, points: CGPoint(x: viewFrames.origin.x - 20, y: viewFrames.origin.y - 20))
        overLay(size: centerSize, points: CGPoint(x: viewFrames.width / 2 - 30, y: viewFrames.origin.y - 30))
        overLay(size: cornerSize, points: CGPoint(x: viewFrames.origin.x + viewFrames.width - 20, y: viewFrames.origin.y - 20))
    }
    
    private func setupConstraints() {
        [runtimeLabel, titleLabel, backdropImage,
         genreHeading, directorsHeading, starsHeading,
         genreLabel, directorsLabel, starsLabel,
         separator, plotTextView, starsView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            runtimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width / 4),
            runtimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: StyleGuide.Spaces.double + 10),
            
            starsView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width / 4),
            starsView.topAnchor.constraint(equalTo: self.topAnchor, constant: StyleGuide.Spaces.double + 10),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: StyleGuide.Spaces.double),
            titleLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: StyleGuide.Spaces.double * 2),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -StyleGuide.Spaces.double * 2),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            backdropImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backdropImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: StyleGuide.Spaces.double),
            backdropImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backdropImage.heightAnchor.constraint(equalToConstant: 200),

            genreHeading.topAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: StyleGuide.Spaces.double),
            genreHeading.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width / 4),
            
            genreLabel.leadingAnchor.constraint(equalTo: genreHeading.trailingAnchor, constant: StyleGuide.Spaces.double),
            genreLabel.topAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: StyleGuide.Spaces.double),
            genreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -StyleGuide.Spaces.double),
            
            directorsHeading.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: StyleGuide.Spaces.double),
            directorsHeading.trailingAnchor.constraint(equalTo: genreHeading.trailingAnchor),
            
            directorsLabel.leadingAnchor.constraint(equalTo: directorsHeading.trailingAnchor, constant: StyleGuide.Spaces.double),
            directorsLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: StyleGuide.Spaces.double),
            directorsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -StyleGuide.Spaces.double),
            
            starsHeading.topAnchor.constraint(equalTo: directorsLabel.bottomAnchor, constant: StyleGuide.Spaces.double),
            starsHeading.trailingAnchor.constraint(equalTo: directorsHeading.trailingAnchor),

            starsLabel.leadingAnchor.constraint(equalTo: starsHeading.trailingAnchor, constant: StyleGuide.Spaces.double),
            starsLabel.topAnchor.constraint(equalTo: directorsLabel.bottomAnchor, constant: StyleGuide.Spaces.double),
            starsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -StyleGuide.Spaces.double),
            
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.topAnchor.constraint(equalTo: starsLabel.bottomAnchor, constant: StyleGuide.Spaces.double),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            plotTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: StyleGuide.Spaces.double),
            plotTextView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: StyleGuide.Spaces.single),
            plotTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -StyleGuide.Spaces.double),
            plotTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -StyleGuide.Spaces.double)
        ])
    }
}
