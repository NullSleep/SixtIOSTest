//
//  SixtCarFinders.swift
//  SixtCarFinders
//
//  Created by Carlos Arenas on 6/1/19.
//  Copyright © 2019 CA. All rights reserved.
//

import XCTest
@testable import SixtCarFinder

class SixtCarFinders: XCTestCase {

  override func setUp() {
  }

  override func tearDown() {
  }

  func testMapScreen() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    XCTAssertNotNil(sb, "Could not instantiate storyboard for Settings View creation")
    let viewcontroller = storyboard.instantiateViewController(withIdentifier: "MapVC") as? MapViewController
    XCTAssertNotNil(viewcontroller, "Could not instantiate Settings view controller")
    _ = viewcontroller?.view
  }

  func testCarListScreen() {
    let storyboard = UIStoryboard(name: "CarList", bundle: nil)
    XCTAssertNotNil(sb, "Could not instantiate storyboard for Settings View creation")
    let viewcontroller = storyboard.instantiateViewController(withIdentifier: "CarListVC") as? CarListViewController
    XCTAssertNotNil(vc, "Could not instantiate Settings view controller")
    _ = viewcontroller?.view
  }

}
