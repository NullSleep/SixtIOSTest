//
//  CarArtwork.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 6/1/19.
//  Copyright © 2019 CA. All rights reserved.
//

import Foundation
import MapKit
import Contacts

public class CarLocationAnnotation: NSObject, MKAnnotation {
  public let title      : String?
  public let coordinate : CLLocationCoordinate2D
  public let carInfo    : CarItem
  
  init(title: String, ownerName: String, carInfo: CarItem, latitude: Double, longitude: Double, color: String) {
    self.title = title
    self.carInfo = carInfo
    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    
    super.init()
  }
  
  init?(for carItem: CarItem) {
    self.title = carItem.modelName
    self.carInfo = carItem
    self.coordinate = CLLocationCoordinate2D(latitude: carItem.latitude, longitude: carItem.longitude)
    
    super.init()
  }
  
  // Annotation right callout accessory opens this mapItem in Maps app
  func mapItem() -> MKMapItem {
    let addressDict = [CNPostalAddressStreetKey: carInfo.ownerName]
    let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = title
    return mapItem
  }
}
