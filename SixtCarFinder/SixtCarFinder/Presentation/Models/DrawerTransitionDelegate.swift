//
//  DrawerTransitionDelegate.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/30/19.
//  Copyright © 2019 CA. All rights reserved.
//

import UIKit

final class DrawerTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

  // MARK: - Class properties
  private let vcToPresent: UIViewController
  private weak var presentingVC: UIViewController?

  // MARK: - Initializer
  init(viewControllerToPresent: UIViewController, presentingViewController: UIViewController) {
    self.vcToPresent = viewControllerToPresent
    self.presentingVC = presentingViewController
  }

  // MARK: - Public
  public func presentationController(forPresented presented: UIViewController,
                                     presenting: UIViewController?,
                                     source: UIViewController) -> UIPresentationController? {
    return DrawerPresentationController(presentedViewController: presented, presenting: presenting)
  }
}
