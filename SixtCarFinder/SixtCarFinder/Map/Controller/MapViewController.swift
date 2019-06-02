//
//  MapViewController.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/29/19.
//  Copyright © 2019 CA. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  // MARK: - Properties
  private var carLocations: [CarLocationAnnotation] = []
  private let regionRadius: CLLocationDistance = 9000
  private let locationManager = CLLocationManager()
  
  // MARK: - IBOutlets
  @IBOutlet weak var mapView: MKMapView!
  
  // MARK: - Injections
  internal var networkHandler = NetworkHandler.shared
  private var animator: DrawerTransitionDelegate?
  
  // MARK: - View life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // First we configure the map view
    configureMapView()
    
    // Now we load the car data
    loadCarList()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard let locationsViewController = UIStoryboard(name: "CarList", bundle: nil).instantiateViewController(withIdentifier: "CarListVC") as? CarListViewController else { return }
    
    animator = DrawerTransitionDelegate(viewControllerToPresent: locationsViewController, presentingViewController: self)
    locationsViewController.transitioningDelegate = animator
    locationsViewController.modalPresentationStyle = .custom
    
    present(locationsViewController, animated: true)
    
    // Check user for location authorization status
    checkLocationAuthorizationStatus()
  }
}

// MARK: - Private mehtods
extension MapViewController {
  
  private func configureMapView() {
    // Set initial location in Munich
    let initialLocation = CLLocation(latitude: 48.1351, longitude: 11.5820)
    centerMapOnLocation(location: initialLocation)
    mapView.delegate = self
    mapView.register(CarMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
  }
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
  func addLocationsIntoMapView(for carList: [CarItem]) {
    let validWorks = carList.compactMap { CarLocationAnnotation(for: $0) }
    carLocations.append(contentsOf: validWorks)
    mapView.addAnnotations(carLocations)
  }
  
  private func loadCarList() {
    networkHandler.getCarList(
      success: { [weak self] carList in
        
        guard let strongSelf = self else { return }
        strongSelf.addLocationsIntoMapView(for: carList)
        print("\(carList)")
        
      }, failure: { [weak self] error in
        print("Car list download failed: \(error)")
        //guard let strongSelf = self else { return }
    })
  }
}

// MARK: - CLLocationManager
extension MapViewController {
  
  func checkLocationAuthorizationStatus() {
    if CLLocationManager.authorizationStatus() == .authorizedAlways {
      mapView.showsUserLocation = true
    } else {
      locationManager.requestAlwaysAuthorization()
    }
  }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {

  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    let location = view.annotation as! CarLocationAnnotation
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    location.mapItem().openInMaps(launchOptions: launchOptions)
  }
  
}
