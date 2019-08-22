//
//  Stop.swift
//  BusGossips
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import Foundation

class Stop {
    
    init(drivers: [Driver]) {
        self.drivers = drivers
    }
    
    let drivers: [Driver]
    
    func exchangeGossips() {
        for (index, driver) in drivers.enumerated() {
            let otherDrivers: Array = drivers.suffix(drivers.count - index)
            
            tellGossip(from: driver,
                       to: otherDrivers)
        }
    }
    
    private func tellGossip(from teller: Driver, to otherDrivers: [Driver]) {
        for anotherDriver in otherDrivers {
            exchangeGossips(between: teller, and: anotherDriver)
        }
    }
    
    private func exchangeGossips(between driver1: Driver, and driver2: Driver) {
        driver1.hearGossips(from: driver2)
        driver2.hearGossips(from: driver1)
    }
}

extension Stop: Equatable {
    static func == (lhs: Stop, rhs: Stop) -> Bool {
        return lhs.drivers == rhs.drivers
    }
}
