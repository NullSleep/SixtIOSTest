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
  public let modelName   : String
  public let name        : String
  public let coordinate  : CLLocationCoordinate2D
  public var imageName   : String?
  public var color       : String
  
  init(modelName: String, name: String, discipline: String, latitude: Double, longitude: Double, color: String) {
    self.modelName = modelName
    self.name = name
    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    self.imageName = "carIconSmall"
    self.color = color
    
    super.init()
  }
  
  init?(for carItem: CarItem) {
    self.modelName = carItem.modelName
    self.name = carItem.name
    self.coordinate = CLLocationCoordinate2D(latitude: carItem.latitude, longitude: carItem.longitude)
    self.imageName = "carIconSmall"
    self.color = carItem.color
    
    super.init()
  }
  
  // MarkerTintColor given the car item color
  var markerTintColor: UIColor  {
    switch color {
    case "midnight_black", "midnight_black_metal", "absolute_black_metal":
      return .black
    case "hot_chocolate", "iced_chocolate":
      return .brown
    case "light_white", "alpinweiss":
      return .white
    case "saphirschwarz", "schwarz":
      return .darkGray
    default:
      return .orange
    }
  }
  
  // Annotation right callout accessory opens this mapItem in Maps app
  func mapItem() -> MKMapItem {
    let addressDict = [CNPostalAddressStreetKey: name]
    let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = modelName
    return mapItem
  }
}
