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
  private var artworks: [CarArtwork] = []
  private let regionRadius: CLLocationDistance = 1000
  private let locationManager = CLLocationManager()
  
  // MARK: - IBOutlet
  @IBOutlet weak var mapView: MKMapView!
  
  // MARK: - Injections
  internal var networkHandler = NetworkHandler.shared
  private var animator: DrawerTransitionDelegate?
  
  // MARK: - View life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadCarList()
    configureMapView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard let locationsViewController = UIStoryboard(name: "CarList", bundle: nil).instantiateViewController(withIdentifier: "CarListVC") as? CarListViewController else { return }
    
    animator = DrawerTransitionDelegate(viewControllerToPresent: locationsViewController, presentingViewController: self)
    locationsViewController.transitioningDelegate = animator
    locationsViewController.modalPresentationStyle = .custom
    
    present(locationsViewController, animated: true)
  }
}

// MARK: - Private mehtods
extension MapViewController {
  
  private func configureMapView() {
    // set initial location in Honolulu
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    centerMapOnLocation(location: initialLocation)
    
    mapView.delegate = self
    mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    loadInitialData()
    mapView.addAnnotations(artworks)
  }
  
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
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
  func loadInitialData() {
    // 1
    guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
      else { return }
    let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
    
    guard let data = optionalData,
      let json = try? JSONSerialization.jsonObject(with: data),
      let dictionary = json as? [String: Any],
      let works = dictionary["data"] as? [[Any]]
      else { return }
    
    let validWorks = works.compactMap { CarArtwork(json: $0) }
    artworks.append(contentsOf: validWorks)
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
//    let location = view.annotation as! CarArtwork
//    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//    location.mapItem().openInMaps(launchOptions: launchOptions)
  }
  
}
