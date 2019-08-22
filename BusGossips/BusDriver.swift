//
//  BusDriver.swift
//  BusGossips
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import Foundation

class Driver {
    let route: [Int]
    var gossips = Set<String>()
    
    func stop(at minute: Int) -> Int {
        return route[minute % route.count]
    }
    
    init(route: [Int], gossip: String = UUID().uuidString) {
        self.route = route
        self.gossips = [gossip]
    }
    
    func hearGossips(from driver: Driver) {
        gossips = gossips.union(driver.gossips)
    }
}

extension Driver: Equatable {
    static func == (lhs: Driver, rhs: Driver) -> Bool {
        return lhs.route == rhs.route
            && lhs.gossips == rhs.gossips
    }
}

class City {
    init(drivers: [Driver]) {
        self.allDrivers = drivers
    }
    
    let allDrivers: [Driver]
    
    func drivers(atStop currentStop: Int, minute: Int = 0) -> [Driver] {
        return allDrivers
            .filter { $0.stop(at: minute) == currentStop }
    }
    
    var allStops: [Int] {
        var stops = Set<Int>()
        
        for driver in allDrivers {
            for stop in driver.route {
                stops.insert(stop)
            }
        }
        
        return Array(stops).sorted()
    }
    
    func stopsWithSeveralDrivers(minute: Int) -> [Stop] {
        let stopsWithDrivers = allStops
            .map { stop in
                drivers(atStop: stop,
                        minute: minute) }
            .filter { driversOnStop in
                driversOnStop.count > 1 }
            .map { Stop(drivers: $0) }
        
        return stopsWithDrivers
    }
    
    func exchangeGossipes() {
        let stops = stopsWithSeveralDrivers(minute: 0)
        for stop in stops {
            stop.exchangeGossips()
        }
    }
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.allDrivers == rhs.allDrivers
    }
}

class Stop {
    
    init(drivers: [Driver]) {
        self.drivers = drivers
    }
    
    let drivers: [Driver]
    
    func exchangeGossips() {
        let driver1 = drivers.first!
        let driver2 = drivers.last!
        
        driver1.hearGossips(from: driver2)
        driver2.hearGossips(from: driver1)
    }
}

extension Stop: Equatable {
    static func == (lhs: Stop, rhs: Stop) -> Bool {
        return lhs.drivers == rhs.drivers
    }
}

class Schedule {
    init(city: City) {
        self.city = city
    }
    
    let city: City
    
    @discardableResult
    func moveDriversAllDay() -> String {
        for minute in 0..<dayLengthInMinutes {
            exchangeGossips(minute: minute)
            
            if allDriversKnewEverything() {
                return "\(minute + 1)"
            }
        }
        
        return "never"
    }
    
    private let dayLengthInMinutes = 60 * 8
    
    private func exchangeGossips(minute: Int) {
        for stop in city.stopsWithSeveralDrivers(minute: minute) {
            stop.exchangeGossips()
        }
    }
    
    private func allDriversKnewEverything() -> Bool {
        let maxGossipsCount = city.allDrivers.count
        let driversThatKnewEverything = city.allDrivers
            .filter { $0.gossips.count == maxGossipsCount }
        
        return driversThatKnewEverything.count == city.allDrivers.count
    }
}
