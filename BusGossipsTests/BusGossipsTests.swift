//
//  BusGossipsTests.swift
//  BusGossipsTests
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import XCTest
@testable import BusGossips

// http://kata-log.rocks/gossiping-bus-drivers-kata

// ver 1
// 3 1 2 3
// 3 2 3 1
// 4 2 3 4 5
// output: 5

// ver 2
// 2 1 2
// 5 2 8
// output: never

class BusGossipsTests: XCTestCase {
    
    let driver = Driver(route: [3, 1, 2, 3])
    
    func test_driverHasRoute() {
        XCTAssertEqual(driver.route, [3, 1, 2, 3])
    }
    
    func test_driverMovesToNextStop() {
        XCTAssertEqual(3, driver.stop(at: 0))
        XCTAssertEqual(1, driver.stop(at: 1))
        XCTAssertEqual(2, driver.stop(at: 2))
        XCTAssertEqual(3, driver.stop(at: 3))
    }
    
    func test_driverRouteIsRepeated() {
        XCTAssertEqual(3, driver.stop(at: 4))
        XCTAssertEqual(1, driver.stop(at: 5))
        XCTAssertEqual(2, driver.stop(at: 6))
        XCTAssertEqual(3, driver.stop(at: 7))
    }
}

class CityTests: XCTestCase {
    
    func test_cityHasBusDriver() {
        let city = City(drivers: [Driver(route: [3, 1, 2, 3])])
        
        XCTAssertEqual(1, city.allDrivers.count)
    }
    
    func test_cityReturnsDriversByStopNumber() {
        let driver1 = Driver(route: [3, 1, 2, 3])
        let driver2 = Driver(route: [3, 2, 3, 1])
        
        let city = City(drivers: [driver1, driver2])

        XCTAssertEqual([driver1, driver2], city.drivers(atStop: 1))
    }
}
