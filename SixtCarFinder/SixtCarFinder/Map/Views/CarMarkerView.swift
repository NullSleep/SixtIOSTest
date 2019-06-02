//
//  CarMarkerView.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 6/1/19.
//  Copyright © 2019 CA. All rights reserved.
//

import Foundation
import MapKit

class CarMarkerView: MKAnnotationView {
  
  override var annotation: MKAnnotation? {
    willSet {
      guard let carLocation = newValue as? CarLocationAnnotation else {return}
      
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      
      let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
      mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControl.State())
      rightCalloutAccessoryView = mapsButton
      
//      if let imageName = carLocation.carInfo.carImageUrl {
//        image = UIImage(named: imageName)
//      } else {
//        image = UIImage(named: "carIconSmall")
//      }
      image = UIImage(named: "carIconSmall")
      
      let carInfoText = "Owner: " + carLocation.carInfo.ownerName + "\n"
        + "Maker: " + carLocation.carInfo.make + "\n"
        + "Fuel Type: " + carLocation.carInfo.fuelType + "\n"
        + "Fuel Level: " + carLocation.carInfo.carFuelPercentage + "\n"
        + "Transmission: " + carLocation.carInfo.carTransmission + "\n"
        + "Cleanliness: " + carLocation.carInfo.cleanliness
      
      let detailLabel = UILabel()
      detailLabel.numberOfLines = 0
      detailLabel.font = detailLabel.font.withSize(13)
      detailLabel.text = carInfoText
      detailCalloutAccessoryView = detailLabel
    }
  }
  
}
