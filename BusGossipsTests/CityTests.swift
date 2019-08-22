//
//  CityTests.swift
//  BusGossipsTests
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import XCTest
@testable import BusGossips

class CityTests: XCTestCase {
    
    let driver1 = Driver(route: [3, 1, 2, 3])
    let driver2 = Driver(route: [3, 2, 3, 1])
    let driver3 = Driver(route: [4, 2, 3, 4, 5])
    
    func test_cityHasBusDriver() {
        let city = City(drivers: [driver1])
        
        XCTAssertEqual(1, city.allDrivers.count)
    }
    
    func test_cityReturnsDriversByStopNumber() {
        let city = City(drivers: [driver1, driver2])
        
        XCTAssertEqual([driver1, driver2], city.drivers(atStop: 3))
    }
    
    func test_cityReturnsDriversByStopNumberAndMinute() {
        let city = City(drivers: [driver1, driver2])
        
        XCTAssertEqual([driver1], city.drivers(atStop: 1, minute: 1))
    }
    
    func test_cityKnowsAboutAllStops() {
        let city = City(drivers: [driver1, driver2])
        
        XCTAssertEqual([1, 2, 3], city.allStops)
    }
    
    func test_cityKnowsDriversOnSameStops() {
        let city = City(drivers: [driver1, driver2, driver3])
        
        XCTAssertEqual(
            [Stop(drivers: [driver1, driver2])],
            city.stopsWithSeveralDrivers(minute: 0))
        
        XCTAssertEqual(
            [Stop(drivers: [driver2, driver3])],
            city.stopsWithSeveralDrivers(minute: 1))
        
        XCTAssertEqual(
            [Stop(drivers: [driver2, driver3])],
            city.stopsWithSeveralDrivers(minute: 2))
        
        XCTAssertEqual([], city.stopsWithSeveralDrivers(minute: 3))
    }
    
    // MARK: - Gossips
    func test_driversExchangesGossipesOnCommonStops() {
        let city = City(drivers: [driver1, driver2, driver3])
        
        city.exchangeGossipes()
        
        XCTAssertEqual(driver1.gossips.count, 2)
        XCTAssertEqual(driver2.gossips.count, 2)
        XCTAssertEqual(driver3.gossips.count, 1)
    }
}
