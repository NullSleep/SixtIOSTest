//
//  CarArtwork.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 6/1/19.
//  Copyright © 2019 CA. All rights reserved.
//

import Foundation
import MapKit

class CarArtwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String
  let discipline: String
  let coordinate: CLLocationCoordinate2D
  
  init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    
    super.init()
  }
  
  init?(json: [Any]) {
    if let title = json[16] as? String {
      self.title = title
    } else {
      self.title = "No Title"
    }
    
    self.locationName = json[11] as! String
    
    self.discipline = json[15] as! String
  
    if let latitude = Double(json[18] as! String),
      let longitude = Double(json[19] as! String) {
      self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    } else {
      self.coordinate = CLLocationCoordinate2D()
    }
  }
  
  var subtitle: String? {
    return locationName
  }
  
  var markerTintColor: UIColor  {
    switch discipline {
    case "Monument":
      return .red
    case "Mural":
      return .cyan
    case "Plaque":
      return .blue
    case "Sculpture":
      return .purple
    default:
      return .green
    }
  }
  
  var imageName: String? {
    if discipline == "Sculpture" { return "Statue" }
    return "Flag"
  }
}
