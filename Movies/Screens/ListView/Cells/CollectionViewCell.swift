//
//  CollectionViewCell.swift
//  Movies
//
//  Created by Alex Bro on 20.12.2020.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    var viewModel: CollectionCellViewModel?
    private let posterImage = UIImageView()
    private let bgView = UIView(backgroundColor: .darkBlue, alpha: 0.9)
    private let titleLabel = UILabel(font: .default20)
    private let genreLabel = UILabel(textColor: .lightGray, font: .default14)
    private let separator = UILabel(text: "\u{00B7}", textColor: .lightGray, font: .default14)
    private let yearLabel = UILabel(textColor: .lightGray, font: .default14)
    private let runtimeLabel = UILabel(font: .default14)
    private let ratingIcon = UIImageView(image: UIImage(systemName: "star.fill"), tintColor: .systemYellow)
    private let ratingLabel = UILabel(font: .default20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupGanreYearStackView()
        setupRatingStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
        titleLabel.text = nil
        genreLabel.text = nil
        yearLabel.text = nil
        runtimeLabel.text = nil
        ratingLabel.text = nil
    }
    
    func configureView(withModel model: CollectionCellViewModel) {
        viewModel = model
        titleLabel.text = model.title
        genreLabel.text = model.genre
        yearLabel.text = model.year
        runtimeLabel.text = String.runTimeConverter(string: model.runtime)
        ratingLabel.text = model.rating
        posterImage.setImage(URLString: model.poster ?? "")
    }
    
    private func setupGanreYearStackView() {
        let stackView = UIStackView(arrangedSubviews: [yearLabel, separator, genreLabel],
                                    spacing: 5.0, semanticContentAttribute: .forceRightToLeft)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: StyleGuide.Spaces.small),
            stackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    private func setupRatingStackView() {
        let stackView = UIStackView(arrangedSubviews: [ratingIcon, ratingLabel], spacing: 2.5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -StyleGuide.Spaces.single),
            stackView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -StyleGuide.Spaces.small)
        ])
    }
    
    private func setupConstraints() {
        [posterImage, bgView, titleLabel, runtimeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bgView.heightAnchor.constraint(equalToConstant: contentView.frame.height / 3),
            
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: StyleGuide.Spaces.single),
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: StyleGuide.Spaces.single),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -StyleGuide.Spaces.single),

            runtimeLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: StyleGuide.Spaces.single),
            runtimeLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -StyleGuide.Spaces.small),
        ])
    }
}
