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
        for i in 0..<drivers.count - 1 {
            let driver = drivers[i]
            
            for j in (i + 1)..<drivers.count {
                let anotherDriver = drivers[j]
                
                driver.hearGossips(from: anotherDriver)
                anotherDriver.hearGossips(from: driver)
            }
        }
    }
}

extension Stop: Equatable {
    static func == (lhs: Stop, rhs: Stop) -> Bool {
        return lhs.drivers == rhs.drivers
    }
}
