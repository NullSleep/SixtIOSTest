//
//  CarMarkerView.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 6/1/19.
//  Copyright © 2019 CA. All rights reserved.
//

import Foundation
import MapKit

class CarMarkerView: MKMarkerAnnotationView {
  
  override var annotation: MKAnnotation? {
    willSet {
      guard let artwork = newValue as? CarArtwork else { return }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      
      markerTintColor = artwork.markerTintColor
      if let imageName = artwork.imageName {
        glyphImage = UIImage(named: imageName)
      } else {
        glyphImage = nil
      }
    }
  }
  
}

class ArtworkView: MKAnnotationView {
  
  override var annotation: MKAnnotation? {
    willSet {
      guard let artwork = newValue as? CarArtwork else {return}
      
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
      mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControl.State())
      rightCalloutAccessoryView = mapsButton
      
      if let imageName = artwork.imageName {
        image = UIImage(named: imageName)
      } else {
        image = nil
      }
      
      let detailLabel = UILabel()
      detailLabel.numberOfLines = 0
      detailLabel.font = detailLabel.font.withSize(12)
      detailLabel.text = artwork.subtitle
      detailCalloutAccessoryView = detailLabel
    }
  }
  
}
