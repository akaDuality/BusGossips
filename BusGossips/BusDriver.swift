//
//  BusDriver.swift
//  BusGossips
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import Foundation

struct Driver: Equatable {
    let route: [Int]
    var gossips = Set<String>()
    
    func stop(at minute: Int) -> Int {
        return route[minute % route.count]
    }
    
    init(route: [Int], gossip: String = UUID().uuidString) {
        self.route = route
        self.gossips = [gossip]
    }
    
    mutating func hearGossips(from driver: Driver) {
        gossips = gossips.union(driver.gossips)
    }
}

extension Driver: CustomStringConvertible {
    var description: String {
        return "Driver: \(route)"
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
}

struct Stop: Equatable {
    let drivers: [Driver]
}
