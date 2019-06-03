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
    let sb = UIStoryboard(name: "Main", bundle: nil)
    XCTAssertNotNil(sb, "Could not instantiate storyboard for Settings View creation")
    let vc = sb.instantiateViewController(withIdentifier: "MapVC") as? MapViewController
    XCTAssertNotNil(vc, "Could not instantiate Settings view controller")
    _ = vc?.view
  }
  
  func testCarListScreen() {
    let sb = UIStoryboard(name: "CarList", bundle: nil)
    XCTAssertNotNil(sb, "Could not instantiate storyboard for Settings View creation")
    let vc = sb.instantiateViewController(withIdentifier: "CarListVC") as? CarListViewController
    XCTAssertNotNil(vc, "Could not instantiate Settings view controller")
    _ = vc?.view
  }

}
