//
//  Schedule.swift
//  BusGossips
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import Foundation

class Schedule {
    init(city: City) {
        self.city = city
    }
    
    let city: City
    
    @discardableResult
    func moveDriversAllDay() -> String {
        for minute in 0..<dayLengthInMinutes {
            exchangeGossips(minute: minute)
            
            if allDriversKnewEverything() {
                return "\(minute + 1)"
            }
        }
        
        return "never"
    }
    
    private let dayLengthInMinutes = 60 * 8
    
    private func exchangeGossips(minute: Int) {
        for stop in city.stopsWithSeveralDrivers(minute: minute) {
            stop.exchangeGossips()
        }
    }
    
    private func allDriversKnewEverything() -> Bool {
        let maxGossipsCount = city.allDrivers.count
        let driversThatKnewEverything = city.allDrivers
            .filter { $0.gossips.count == maxGossipsCount }
        
        return driversThatKnewEverything.count == city.allDrivers.count
    }
}
