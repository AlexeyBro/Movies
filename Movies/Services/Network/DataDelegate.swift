//
//  DataDelegate.swift
//  Movies
//
//  Created by Alex Bro on 25.12.2020.
//

import UIKit

protocol MovieModelDelegate: AnyObject {
    func updateData(withModel model: [MovieModel?])
}

protocol SearchMovieDelegate: AnyObject {
    func updateData(withModel model: [SearchMovie]?)
}

protocol BackdropDelegate: AnyObject {
    func updateBackdrop(backdropPath string: String?)
}
