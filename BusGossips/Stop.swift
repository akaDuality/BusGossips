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
