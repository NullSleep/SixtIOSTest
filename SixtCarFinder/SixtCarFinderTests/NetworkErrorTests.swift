//
//  NetworkErrorTests.swift
//  SixtCarFinderTests
//
//  Created by Carlos Arenas on 6/2/19.
//  Copyright © 2019 CA. All rights reserved.
//

import XCTest
@testable import SixtCarFinder

class NetworkErrorTests: XCTestCase {

  override func setUp() {
  }
  
  override func tearDown() {
  }
  
  func testBaseError() {
    let netwrorkError = NetworkError(error: CustomError(message: "Fatal error"))
    XCTAssertEqual(netwrorkError.localizedDescription, "The operation couldn’t be completed. (SixtCarFinder.NetworkError error 0.)")
  }
  
  func testErrorEquatable() {
    let baseError = CustomError(message: "Fatal error")
    let netwrorkError = NetworkError(error: baseError)
    let seconDnetwrorkError = NetworkError(error: baseError)
    XCTAssertEqual(netwrorkError, seconDnetwrorkError)
  }

}
