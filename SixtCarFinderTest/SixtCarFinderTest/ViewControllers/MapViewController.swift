//
//  ViewController.swift
//  SixtCarFinderTest
//
//  Created by Carlos Arenas on 5/29/19.
//  Copyright © 2019 CA. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

  private var animator: DrawerTransitionDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard let locationsViewController = UIStoryboard(name: "LocationsList", bundle: nil).instantiateViewController(withIdentifier: "LocationsViewController") as? LocationsListViewController else { return }
    
    animator = DrawerTransitionDelegate(viewControllerToPresent: locationsViewController, presentingViewController: self)
    locationsViewController.transitioningDelegate = animator
    locationsViewController.modalPresentationStyle = .custom
    
    present(locationsViewController, animated: true)
  }
}

