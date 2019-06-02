//
//  CarItem.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/31/19.
//  Copyright © 2019 CA. All rights reserved.
//

import Foundation

public struct CarItem: Codable {
  let id               : String
  let modelIdentifier  : String
  let modelName        : String
  let name             : String
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
  let carImageUrl      : String
  
  enum CodingKeys: String, CodingKey {
    case id
    case modelIdentifier
    case modelName
    case name
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
}
