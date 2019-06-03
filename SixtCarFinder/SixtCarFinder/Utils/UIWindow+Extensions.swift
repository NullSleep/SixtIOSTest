//
//  UIWindow+Extensions.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/30/19.
//  Copyright © 2019 CA. All rights reserved.
//

import UIKit

extension UIWindow {

  @objc public class var root: UIWindow {
    guard let optionalRootWindow = UIApplication.shared.delegate?.window,
      let rootWindow = optionalRootWindow else { fatalError("Fatal Error: delegate's window is nil!") }
    return rootWindow
  }

  public class var key: UIWindow {
    guard let keyWindow = UIApplication.shared.keyWindow else {
      fatalError("Fatal Error: now window is set to keyWindow")
    }
    return keyWindow
  }
}
