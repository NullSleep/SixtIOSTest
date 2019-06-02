//
//  CarItem.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/31/19.
//  Copyright © 2019 CA. All rights reserved.
//

import Foundation
import UIKit

public struct CarItem: Codable {
  
  // CarItem struct properties
  let id               : String
  let modelIdentifier  : String
  let modelName        : String
  let ownerName        : String
  let make             : String
  let group            : String
  let color            : String
  let series           : String
  let fuelType         : String
  let fuelLevel        : Float
  let transmission     : String
  let licensePlate     : String
  let latitude         : Double
  let longitude        : Double
  let innerCleanliness : String
  let carImageUrl      : String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case modelIdentifier
    case modelName
    case ownerName = "name"
    case make
    case group
    case color
    case series
    case fuelType
    case fuelLevel
    case transmission
    case licensePlate
    case latitude
    case longitude
    case innerCleanliness
    case carImageUrl
  }
  
  // UIColor represnetation of the given car color
  var carColor: UIColor  {
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
  
  // String represnetation of the given car fuel in percentage form
  var carFuelPercentage: String  {
    return String(fuelLevel * 100) + "%"
  }
  
  // String represnetation of the given car transmission
  var carTransmission: String  {
    switch transmission {
    case "M":
      return "Manual"
    case "A":
      return "Automatic"
    default:
      return "Not specified"
    }
  }
  
  // Processing the cleanliness value of a car
  var cleanliness: String {
    let newString = innerCleanliness.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
    return newString.capitalized
  }
}
