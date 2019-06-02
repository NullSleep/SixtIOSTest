//
//  CarMarkerView.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 6/1/19.
//  Copyright © 2019 CA. All rights reserved.
//

import Foundation
import MapKit
import SDWebImage

class CarMarkerView: MKAnnotationView {
  
  override var annotation: MKAnnotation? {
    willSet {
      guard let carLocation = newValue as? CarLocationAnnotation else {return}
      
      canShowCallout = true
      calloutOffset = CGPoint(x: 0, y: 5)
      
      let carImageButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 135, height: 90)))
      carImageButton.backgroundColor = .black
      if let imageURL = carLocation.carInfo.carImageUrl {
        carImageButton.sd_setBackgroundImage(with: URL(string: imageURL), for: UIControl.State(), placeholderImage: UIImage(named: "defaultCarImg"))
      } else {
        carImageButton.setBackgroundImage(UIImage(named: "defaultCarImg"), for: UIControl.State())
      }
      carImageButton.layer.cornerRadius = 8.0
      carImageButton.layer.masksToBounds = false
    
      rightCalloutAccessoryView = carImageButton
      
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
