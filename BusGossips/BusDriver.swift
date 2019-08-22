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
    
    func stop(at minute: Int) -> Int {
        return route[minute % route.count]
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
        var pairs = [[Driver]]()
        
        for stop in allStops {
            let commonDrivers = drivers(atStop: stop, minute: minute)
            
            guard commonDrivers.count > 1 else {
                continue
            }
                
            pairs.append(commonDrivers)
        }
        
        return pairs
    }
}
