//
//  ArgAnyTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class ArgAnyTests: XCTestCase {


    func testDescription() {
        let value = ArgAny("String")
        let desc = value.description
        XCTAssertEqual(desc, "any<String>")
    }


    func testMatch() {
        let any = ArgAny("")
        let match = any.match("Anything")
        XCTAssertTrue(match)
    }
    
}
