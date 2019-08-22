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
    let gossips: [String]
    
    func stop(at minute: Int) -> Int {
        return route[minute % route.count]
    }
    
    init(route: [Int], gossip: String = UUID().uuidString) {
        self.route = route
        self.gossips = [gossip]
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
    
    func driversAtSameStops(minute: Int) -> [[Driver]] {
        let pairs = allStops
            .map { stop in
                drivers(atStop: stop,
                        minute: minute) }
            .filter { driversOnStop in
                driversOnStop.count > 1 }
        
        return pairs
    }
}
