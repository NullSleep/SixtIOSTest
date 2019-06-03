//
//  MapViewController.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/29/19.
//  Copyright © 2019 CA. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit
import MapKit

class MapViewController: UIViewController {

  // MARK: - Class properties
  private let regionRadius: CLLocationDistance = 10000
  private let initialLocation = CLLocation(latitude: 48.1351, longitude: 11.5820)
  private let locationManager = CLLocationManager()

  private var carLocations: [CarLocationAnnotation] = []
  private var carListViewController: CarListViewController?

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

    // Check and instantiate the CarListViewController
    let storyboard = UIStoryboard(name: "CarList", bundle: nil)
    guard let listViewController =
      storyboard.instantiateViewController(withIdentifier: "CarListVC") as? CarListViewController else { return }

    // Set the carListViewController as the drawer view and show it
    animator = DrawerTransitionDelegate(viewControllerToPresent: listViewController, presentingViewController: self)
    listViewController.transitioningDelegate = animator
    listViewController.modalPresentationStyle = .custom

    self.carListViewController = listViewController

    present(self.carListViewController!, animated: true)

    // Check user for location authorization status
    checkLocationAuthorizationStatus()
  }
}

// MARK: - Private methods
extension MapViewController {

  private func configureMapView() {
    // Set initial location in Munich
    centerMapOnLocation(location: initialLocation)
    mapView.delegate = self
    mapView.register(CarMarkerView.self,
                     forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
  }

  private func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }

  private func addLocationsIntoMapView(for carList: [CarItem]) {
    let locations = carList.compactMap { CarLocationAnnotation(for: $0) }
    carLocations.append(contentsOf: locations)
    mapView.addAnnotations(carLocations)
  }

  private func loadCarList() {
    networkHandler?.getCarList(
      success: { [weak self] carList in
        guard let strongSelf = self else { return }
        // Add the locations to the Map view and the Car List View Controller
        strongSelf.addLocationsIntoMapView(for: carList)
        strongSelf.carListViewController?.carList = carList

      }, failure: {  [weak self] error in
        guard let strongSelf = self else { return }
        let alert = UIAlertController(title: "Error downloading the car data",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        strongSelf.present(alert, animated: true, completion: nil)
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

  func mapView(_ mapView: MKMapView,
               annotationView view: MKAnnotationView,
               calloutAccessoryControlTapped control: UIControl) {
    let location = view.annotation as! CarLocationAnnotation
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    location.mapItem().openInMaps(launchOptions: launchOptions)
  }

}
