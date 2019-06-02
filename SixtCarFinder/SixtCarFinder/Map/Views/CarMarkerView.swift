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
      
      let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
      mapsButton.setBackgroundImage(UIImage(named: "AppIcon"), for: UIControl.State())
      rightCalloutAccessoryView = mapsButton
      
      if let imageName = carLocation.imageName {
        image = UIImage(named: imageName)
      } else {
        image = nil
      }
      
      let detailLabel = UILabel()
      detailLabel.numberOfLines = 0
      detailLabel.font = detailLabel.font.withSize(14)
      detailLabel.text = carLocation.name
      detailCalloutAccessoryView = detailLabel
    }
  }
  
}
