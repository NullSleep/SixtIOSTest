//
//  ViewController.swift
//  SixtCarFinderTest
//
//  Created by Carlos Arenas on 5/29/19.
//  Copyright © 2019 CA. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
  
  // MARK: - Injections
  internal var networkHandler = NetworkHandler.shared

  private var animator: DrawerTransitionDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadCarList()
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

// MARK: - Private mehtods
extension MapViewController {
  
  private func loadCarList() {
    
    networkHandler.getCarList(
      success: { [weak self] carList in
        
        //guard let strongSelf = self else { return }
        print("\(carList)")
        
      }, failure: { [weak self] error in
        print("Car list download failed: \(error)")
        //guard let strongSelf = self else { return }
    })
  }
}
