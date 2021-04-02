//
//  UIView+Extension.swift
//  RickAndMorty
//
//  Created by Celal Tok on 1.04.2021.
//

import UIKit

extension UIView {
    
    /// Set your view's spesific corners radius
    /// e.g. .roundCorners(corners: [.topLeft, .topRight], radius: 3.0)
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
