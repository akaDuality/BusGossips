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

class DriverTests: XCTestCase {
    
    var driver: Driver!
    
    override func setUp() {
        driver = Driver(route: [3, 1, 2, 3])
    }
    
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
    
    // MARK: - Gossips
    func test_driverHasGossip() {
        let gossip = "1st gossip"
        let driver = Driver(route: [1, 2], gossip: gossip)
        
        XCTAssertEqual(driver.gossips, [gossip])
    }
    
    func test_driverCanKnowNewGossip() {
        let driver2 = Driver(route: [3, 2, 3, 1])
        
        driver.hearGossips(from: driver2)
        
        XCTAssertEqual(2, driver.gossips.count)
    }
    
    func test_driverIsnotInterestedInKnownGossip() {
        let driver2 = Driver(route: [3, 2, 3, 1])
        
        driver.hearGossips(from: driver2)
        driver.hearGossips(from: driver2) // Repeat gossip
        
        XCTAssertEqual(2, driver.gossips.count)
    }
}

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
    
    func test_cityKnowsDriversOnSampeStops() {
        let city = City(drivers: [driver1, driver2, driver3])
        
        XCTAssertEqual([Stop(drivers: [driver1, driver2])], city.stopsWithSeveralDrivers(minute: 0))
        XCTAssertEqual([Stop(drivers: [driver2, driver3])], city.stopsWithSeveralDrivers(minute: 1))
        XCTAssertEqual([Stop(drivers: [driver2, driver3])], city.stopsWithSeveralDrivers(minute: 2))
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

class ScheduleTests: XCTestCase {
    var driver1: Driver!
    var driver2: Driver!
    var city: City!
    var schedule: Schedule!
    
    override func setUp() {
        driver1 = Driver(route: [3, 1, 2, 3])
        driver2 = Driver(route: [3, 2, 3, 1])
        
        city = City(drivers: [driver1, driver2])
        schedule = Schedule(city: city)
    }
    
    func test_scheduleHasCity() {
        XCTAssertEqual(schedule.city, city)
    }
    
    func test_driversKnowsAllGossipsAtTheDaysEnd() {
        schedule.moveDriversAllDay()
        XCTAssertEqual(driver1.gossips.count, 2)
        XCTAssertEqual(driver2.gossips.count, 2)
    }
    
    func test_whenMaxGossipsCountExchangedDriversStops() {
        let result = schedule.moveDriversAllDay()
        
        XCTAssertEqual(result, "1")
        
    }
}
