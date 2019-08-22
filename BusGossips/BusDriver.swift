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

class City {
    init(drivers: [Driver]) {
        self.allDrivers = drivers
    }
    
    let allDrivers: [Driver]
    
    func drivers(atStop: Int) -> [Driver] {
        return allDrivers
    }
}
