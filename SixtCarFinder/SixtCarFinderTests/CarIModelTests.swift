//
//  CarIModelTests.swift
//  SixtCarFinderTests
//
//  Created by Carlos Arenas on 6/2/19.
//  Copyright © 2019 CA. All rights reserved.
//

import XCTest
@testable import SixtCarFinder

class CarIModelTests: XCTestCase {
  
  let networkHandler = NetworkHandler.shared

  override func setUp() {
  }
  
  override func tearDown() {
  }
  
  // Test the car search JSON results mapping
  func testCarListhResultObjectMapping() {
    guard let jsonFile = Bundle.main.path(forResource: "Resources/SixtCarListResponse", ofType: "json") else { return }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile), options: []) else { return }
    do {
      let carItems = try [JSONDecoder().decode([CarItem].self, from: data)]
      XCTAssertNotNil(carItems)
    } catch {
      XCTFail("Error getting the car items.")
    }
  }

  func testCarModelObjectMappingColor() {
    
    // Create an expectation for a background download task.
    let expectation = XCTestExpectation(description: "Network handler get car list and the car color")
    
    networkHandler?.getCarList( success: { carList in
      if let car = carList.first , car.carColor == .black ||
        car.carColor == .brown ||
        car.carColor == .white ||
        car.carColor == .darkGray ||
        car.carColor == .orange {
        
        // Fulfill the expectation to indicate that the object mapping was successful
        expectation.fulfill()
      } else {
        XCTFail("Error getting the car object.")
      }
    }, failure: { error in
      XCTFail("Error performing the request.")
    })
    
    // Wait until the expectation is fulfilled, with a timeout of 30 seconds.
    wait(for: [expectation], timeout: 30.0)
  }
  
  func testCarModelObjectFuelPercentage() {
    networkHandler?.getCarList( success: { carList in
      if let car = carList.first {
        XCTAssertNotNil(car.carFuelPercentage)
      } else {
        XCTFail("Error getting the car object.")
      }
    }, failure: { error in
      XCTFail("Error performing the request.")
    })
  }
  
  func testGetCarModelObjectMappingTransmission() {
    
    // Create an expectation for a background download task.
    let expectation = XCTestExpectation(description: "Network handler get car list and get the car transmission")
    
    networkHandler?.getCarList( success: { carList in
      if let car = carList.first, car.carTransmission == "Manual" ||
        car.carTransmission == "Automatic" ||
        car.carTransmission == "Not specified" {
        
        // Fulfill the expectation to indicate that the object mapping was successful
        expectation.fulfill()
      } else {
        XCTFail("Error getting the car object.")
      }
    }, failure: { error in
      XCTFail("Error performing the request.")
    })
    
    // Wait until the expectation is fulfilled, with a timeout of 30 seconds.
    wait(for: [expectation], timeout: 30.0)
  }
  
  func testGetCarModelObjectMappingcleanliness() {
    
    networkHandler?.getCarList( success: { carList in
      if let car = carList.first {
        XCTAssertNotNil(car.carCleanliness)
      } else {
        XCTFail("Error getting the car object.")
      }
    }, failure: { error in
      XCTFail("Error performing the request.")
    })
  }

}
