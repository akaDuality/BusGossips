//
//  ScheduleTests.swift
//  BusGossipsTests
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import XCTest
@testable import BusGossips

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
    
    func test_whenMaxGossipsCountForTwoDriversExchangedDriversStops() {
        let result = schedule.moveDriversAllDay()
        
        XCTAssertEqual(result, "1")
    }
    
    func test_whenMaxGossipsCountForThreeDriversExchangedDriversStops() {
        let driver1 = Driver(route: [3, 1, 2, 3])
        let driver2 = Driver(route: [3, 2, 3, 1])
        let driver3 = Driver(route: [4, 2, 3, 4, 5])
        let city = City(drivers: [driver1, driver2, driver3])
        let schedule = Schedule(city: city)
        
        let result = schedule.moveDriversAllDay()
        
        XCTAssertEqual(result, "5")
    }
    
    func test_whenThereIsNoWayToKnowGossips_shouldReturnNever() {
        let driver1 = Driver(route: [2, 1, 2])
        let driver2 = Driver(route: [5, 2, 8])
        
        let city = City(drivers: [driver1, driver2])
        let schedule = Schedule(city: city)
        
        let result = schedule.moveDriversAllDay()
        
        XCTAssertEqual(result, "never")
    }
}
