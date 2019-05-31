//
//  DrawerTransitionDelegate.swift
//  SixtCarFinderTest
//
//  Created by Carlos Arenas on 5/30/19.
//  Copyright © 2019 CA. All rights reserved.
//

import UIKit

final class DrawerTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
  private let vcToPresent: UIViewController
  private weak var presentingVC: UIViewController?
  
  init(viewControllerToPresent: UIViewController, presentingViewController: UIViewController) {
    self.vcToPresent = viewControllerToPresent
    self.presentingVC = presentingViewController
  }
  
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return DrawerPresentationController(presentedViewController: presented, presenting: presenting)
  }
}

