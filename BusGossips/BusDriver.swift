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
    
    init(route: [Int]) {
        self.route = route
    }
    
    func stop(at minute: Int) -> Int {
        return route[minute]
    }
}
