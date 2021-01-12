//
//  String.swift
//  Movies
//
//  Created by Alex Bro on 27.12.2020.
//

import Foundation

extension String {
    static func runTimeConverter(string: String?) -> String {
        var runtime = String()
        if let string = string,
           let number = Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            let hours = number / 60
            let minutes = number % 60
            runtime = "\(hours)h \(minutes)min"
        }
        return runtime
    }
}
