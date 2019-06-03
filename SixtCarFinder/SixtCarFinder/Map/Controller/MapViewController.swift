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
  // Set initial location in the city of Munich
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

  /// Centers the map view, sets its delegate and registers the default annotation.
  private func configureMapView() {
    centerMapOnLocation(location: initialLocation)

    mapView.delegate = self
    mapView.register(CarMarkerView.self,
                     forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
  }

  /// Centers the Map view in a give location and radius
  ///
  /// - Parameter location: The coordinate where to center the Map View
  private func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }

  // Makes the request to get the car list the add the car locations to the Map View and Car List View.
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
        strongSelf.carListViewController?.present(alert, animated: true, completion: nil)
    })
  }

  /// Adds all the car locations annotations to the Map View
  ///
  /// - Parameter carList: Contains the full list of cars from the requests
  private func addLocationsIntoMapView(for carList: [CarItem]) {
    let locations = carList.compactMap { CarLocationAnnotation(for: $0) }
    carLocations.append(contentsOf: locations)
    mapView.addAnnotations(carLocations)
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
