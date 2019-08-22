//
//  City.swift
//  BusGossips
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import Foundation

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
