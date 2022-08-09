//
//  DriverGossipsTests.swift
//  BusGossipsTests
//
//  Created by Mikhail Rubanov on 09.08.2022.
//  Copyright © 2022 akaDuality. All rights reserved.
//

import XCTest
@testable import BusGossips

class DriverGossipsTests: XCTestCase {
    var driver1: Driver!
    var driver2: Driver!
    
    override func setUp() {
        driver1 = Driver(route: [3, 1, 2, 3])
        driver2 = Driver(route: [3, 2, 3, 1])
    }
    
    func test_driverHasGossip() {
        let gossip = "1st gossip"
        let driver = Driver(route: [1, 2], gossip: gossip)
        
        XCTAssertEqual(driver.gossips, [gossip])
    }
    
    func test_driverCanKnowNewGossip() {
        driver1.hearGossips(from: driver2)
        
        XCTAssertEqual(2, driver1.gossips.count)
    }
    
    func test_driverIsNotInterestedInKnownGossip() {
        driver1.hearGossips(from: driver2)
        driver1.hearGossips(from: driver2) // Repeat gossip
        
        XCTAssertEqual(2, driver1.gossips.count)
    }
}
