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
    
    func stop(atMinute minute: Int) -> Int {
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
