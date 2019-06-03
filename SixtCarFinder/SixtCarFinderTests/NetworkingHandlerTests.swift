//
//  NetworkingHandlerTests.swift
//  SixtCarFinderTests
//
//  Created by Carlos Arenas on 6/2/19.
//  Copyright © 2019 CA. All rights reserved.
//

import XCTest
@testable import SixtCarFinder

class NetworkingHandlerTests: XCTestCase {
  
  let networkHandler = NetworkHandler.shared

  override func setUp() {
  }
  
  override func tearDown() {
  }
  
  func testIsNetworkHandlerValid() {
    XCTAssertNotNil(networkHandler, "Network handler singleton not valid.")
  }
  
  func testServerInfo() {
    let serverInfo = NetworkHandler.getServerInfo(for: "ServerEnvironments")
    XCTAssertNotNil(serverInfo, "Server info couldn't be obtained.")
  }
  
  func testIncorrecServerInfo() {
    let serverInfo = NetworkHandler.getServerInfo(for: "DummyEnvironment")
    XCTAssertNil(serverInfo, "Server info found for dummy enviroment.")
  }
  
  func testGetCarListNotNil() {
    networkHandler?.getCarList(
      success: { carList in
        XCTAssertNotNil(carList)
      }, failure: { error in
        XCTFail("Error performing the request.")
      }
    )
  }
  
  func testGetCarListResultsNotEmpty() {
    // Create an expectation for a background download task.
    let expectation = XCTestExpectation(description: "Network handler get car list")
    
    networkHandler?.getCarList(
      success: { carList in
        if carList.count > 0 {
          // Fulfill the expectation to indicate that the background task has finished successfully.
          expectation.fulfill()
        }
    }, failure: { error in
      XCTFail("Error performing the request.")
    })
  }

  func testGetCarListObjectsType() {
    networkHandler?.getCarList( success: { carList in
      if let car = carList.first {
        XCTAssertEqual(String(describing: type(of: car)), "CarItem")
      } else {
        XCTFail("Error getting the car object.")
      }
    }, failure: { error in
      XCTFail("Error performing the request.")
    })
  }

  func testCarLoadPerformance() {
    self.measure {
      networkHandler?.getCarList(
        success: { carList in },
        failure: { error in }
      )
    }
  }

}
