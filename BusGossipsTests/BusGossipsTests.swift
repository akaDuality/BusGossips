//
//  BusGossipsTests.swift
//  BusGossipsTests
//
//  Created by Mikhail Rubanov on 22/08/2019.
//  Copyright © 2019 akaDuality. All rights reserved.
//

import XCTest
@testable import BusGossips

// ver 1
// 3 1 2 3
// 3 2 3 1
// 4 2 3 4 5
// output: 5

// ver 2
// 2 1 2
// 5 2 8
// output: never

class BusGossipsTests: XCTestCase {
    func test_driverHasRoute() {
        let driver = Driver(route: [3, 1, 2, 3])
        
        XCTAssertEqual(driver.route, [3, 1, 2, 3])
    }
}
