//
//  CarLocationAnnotationTests.swift
//  SixtCarFinderTests
//
//  Created by Carlos Arenas on 6/2/19.
//  Copyright © 2019 CA. All rights reserved.
//

import XCTest
@testable import SixtCarFinder

class CarLocationAnnotationTests: XCTestCase {

  let networkHandler = NetworkHandler.shared
  
  override func setUp() {
  }
  
  override func tearDown() {
  }
  
  func testCarLocationAnnotationtObjectMapping() {
    guard let jsonFile = Bundle.main.path(forResource: "Resources/SixtCarListResponse", ofType: "json") else { return }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile), options: []) else { return }
    do {
      let carItems = try JSONDecoder().decode([CarItem].self, from: data)
      if carItems.count > 0 {
        let carLocation = CarLocationAnnotation(for: carItems.first!)
        XCTAssertNotNil(carLocation)
      } else {
        XCTFail("Car list empty.")
      }
    } catch {
      XCTFail("Error getting the car items.")
    }
  }
  
  func testCarLocationAnnotationtCoordinate() {
    guard let jsonFile = Bundle.main.path(forResource: "Resources/SixtCarListResponse", ofType: "json") else { return }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile), options: []) else { return }
    do {
      let carItems = try JSONDecoder().decode([CarItem].self, from: data)
      if carItems.count > 0 {
        let carLocation = CarLocationAnnotation(for: carItems.first!)
        XCTAssertNotNil(carLocation?.coordinate)
      } else {
        XCTFail("Car list empty.")
      }
    } catch {
      XCTFail("Error getting the car items.")
    }
  }
  
  func testCarLocationAnnotationtCarInfo() {
    guard let jsonFile = Bundle.main.path(forResource: "Resources/SixtCarListResponse", ofType: "json") else { return }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile), options: []) else { return }
    do {
      let carItems = try JSONDecoder().decode([CarItem].self, from: data)
      if carItems.count > 0 {
        let carLocation = CarLocationAnnotation(for: carItems.first!)
        XCTAssertNotNil(carLocation?.carInfo)
      } else {
        XCTFail("Car list empty.")
      }
    } catch {
      XCTFail("Error getting the car items.")
    }
  }

}
