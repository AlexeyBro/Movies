//
//  UIView.swift
//  Movies
//
//  Created by Alex Bro on 21.12.2020.
//

import UIKit

extension UIView {
    
    convenience init(backgroundColor: UIColor, alpha: CGFloat) {
        self.init()
        
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
    func createDottedLine(width: CGFloat, color: UIColor) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color.cgColor
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [3, 3]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
}
