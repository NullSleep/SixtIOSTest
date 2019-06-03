//
//  UIView+Extensions.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/30/19.
//  Copyright © 2019 CA. All rights reserved.
//

import UIKit

extension UIView {

  func round(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
}
