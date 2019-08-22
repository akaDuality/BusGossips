//
//  DriverTests.swift
//  DriverTests
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import XCTest
@testable import BusGossips

class DriverTests: XCTestCase {
    
    var driver: Driver!
    
    override func setUp() {
        driver = Driver(route: [3, 1, 2, 3])
    }
    
    func test_driverHasRoute() {
        XCTAssertEqual(driver.route, [3, 1, 2, 3])
    }
    
    func test_driverMovesToNextStop() {
        XCTAssertEqual(3, driver.stop(atMinute: 0))
        XCTAssertEqual(1, driver.stop(atMinute: 1))
        XCTAssertEqual(2, driver.stop(atMinute: 2))
        XCTAssertEqual(3, driver.stop(atMinute: 3))
    }
    
    func test_driverRouteIsRepeated() {
        XCTAssertEqual(3, driver.stop(atMinute: 4))
        XCTAssertEqual(1, driver.stop(atMinute: 5))
        XCTAssertEqual(2, driver.stop(atMinute: 6))
        XCTAssertEqual(3, driver.stop(atMinute: 7))
    }
}

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

extension Driver: CustomStringConvertible {
    public var description: String {
        return "Driver: \(route)"
    }
}
