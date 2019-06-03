//
//  LocationData.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/31/19.
//  Copyright © 2019 CA. All rights reserved.
//

import Foundation

struct LocationData {
  let title: String
  let subtitle: String
  let imgString: String
  
  static var `default`: [LocationData] {
    return [
      LocationData(title: "Mozirje", subtitle: "Mozirje", imgString: "carIcon"),
      LocationData(title: "641 St Peters Ave", subtitle: "641 St Peters Ave, Brooklyn", imgString: "carIcon"),
      LocationData(title: "Nassau St", subtitle: "122 Nassau St, New York", imgString: "carIcon"),
      LocationData(title: "1115 Apple Ave", subtitle: "San Francisco", imgString: "carIcon"),
      LocationData(title: "Facebook NY Office", subtitle: "San Francisco", imgString: "carIcon"),
      LocationData(title: "Mary Turner", subtitle: "Directions from My Location", imgString: "carIcon"),
      LocationData(title: "Hannah Logan's Location", subtitle: "Directions from My Location", imgString: "carIcon"),
      LocationData(title: "Mom's Location", subtitle: "Directions from My Location", imgString: "carIcon"),
      LocationData(title: "Target Location", subtitle: "Directions from My Location", imgString: "carIcon")
    ]
  }
}
