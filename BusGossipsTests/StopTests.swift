//
//  StopTests.swift
//  BusGossipsTests
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import XCTest
@testable import BusGossips

class StopTests: XCTestCase {
    var driver1: Driver!
    var driver2: Driver!
    
    override func setUp() {
        driver1 = Driver(route: [3, 1, 2, 3])
        driver2 = Driver(route: [3, 2, 3, 1])
    }
    
    func test_stopHasDrivers() {
        let stop = Stop(drivers: [driver1, driver2])
        
        XCTAssertEqual(stop.drivers.count, 2)
    }
    
    func test_twoDriversExchangeGossips() {
        let stop = Stop(drivers: [driver1, driver2])
        
        stop.exchangeGossips()
        
        XCTAssertEqual(2, driver1.gossips.count)
        XCTAssertEqual(2, driver2.gossips.count)
    }
}
