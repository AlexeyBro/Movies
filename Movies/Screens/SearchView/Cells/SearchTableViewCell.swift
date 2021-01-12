//
//  SearchTableViewCell.swift
//  Movies
//
//  Created by Alex Bro on 24.12.2020.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    var viewModel: SearchCellViewModel?
    private let bgView = UIView()
    private let posterImage = UIImageView()
    private let titleLabel = UILabel(textColor: .customOrange, font: .defaultBold22)
    private let yearHeader = UILabel(text: "Year", textColor: .customOrange, font: .defaultBold18, textAlignment: .left)
    private let yearLabel = UILabel(textColor: .darkBlue, font: .default16)
    private let favoriteButton = FavoriteButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupBeckgroundView()
        setupNumberOfLine()
        setupConstraints()
        favoriteButton.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        favoriteButton.buttonState()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
        titleLabel.text = nil
        yearLabel.text = nil
    }
    
    func configureView(withModel model: SearchCellViewModel) {
        viewModel = model
        titleLabel.text = model.title
        yearLabel.text = model.year
        posterImage.setImage(URLString: model.poster ?? "")
        favoriteButton.id = model.id
    }
    
    private func setupBeckgroundView() {
        bgView.layer.cornerRadius = StyleGuide.CornerRadius.single
        bgView.backgroundColor = .beige
    }
    
    private func setupNumberOfLine() {
        titleLabel.numberOfLines = 3
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.sizeToFit()
    }
    
    private func setupConstraints() {
        [bgView, posterImage, titleLabel,
         yearLabel, yearHeader, favoriteButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: StyleGuide.Spaces.single),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: StyleGuide.Spaces.single),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -StyleGuide.Spaces.single),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bgView.widthAnchor.constraint(equalToConstant: 100),
        
            posterImage.topAnchor.constraint(equalTo: bgView.topAnchor, constant: StyleGuide.Spaces.single),
            posterImage.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: StyleGuide.Spaces.single),
            posterImage.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -StyleGuide.Spaces.single),
            posterImage.widthAnchor.constraint(equalToConstant: 100),
            posterImage.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: StyleGuide.Spaces.single),
            titleLabel.topAnchor.constraint(equalTo: posterImage.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -StyleGuide.Spaces.single),
            
            yearHeader.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: StyleGuide.Spaces.single),
            yearHeader.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: StyleGuide.Spaces.single),
            
            yearLabel.leadingAnchor.constraint(equalTo: yearHeader.trailingAnchor, constant: StyleGuide.Spaces.small),
            yearLabel.bottomAnchor.constraint(equalTo: yearHeader.bottomAnchor),
            
            favoriteButton.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: StyleGuide.Spaces.single),
            favoriteButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -StyleGuide.Spaces.single),
        ])
    }
}

//MARK: - FavoriteDelegate
extension SearchTableViewCell: FavoriteDelegate {
    func checkItems(forId id: String) -> Bool? {
        viewModel?.checkItems(forId: id)
    }
    
    func addItem(withId id: String) {
        viewModel?.addItem(withId: id)
    }
}
