//
//  ArgConfigurationTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class ArgConfigurationTests: XCTestCase {


    func testDescription_any() {
        let config = ArgConfiguration(value: Int.any, isAny: true)
        let description = config.description
        XCTAssertEqual(description, "any")
    }


    func testDescription_nil() {
        let config = ArgConfiguration(value: nil, isAny: false)
        let description = config.description
        XCTAssertEqual(description, "nil")
    }


    func testDescription_value() {
        let config = ArgConfiguration(value: 32, isAny: false)
        let description = config.description
        XCTAssertEqual(description, "32")
    }

}

