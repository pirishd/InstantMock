//
//  ArgumentClosureTests.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class ArgumentClosureTests: XCTestCase {


    static var allTests = [
        ("testDescription", testDescription),
        ("testMatch", testMatch),
    ]


    func testDescription() {
        let value = ArgumentClosureImpl("(String) -> Int")
        let desc = value.description
        XCTAssertEqual(desc, "closure<(String) -> Int>")
    }


    func testMatch() {
        let any = ArgumentClosureImpl("")
        let match = any.match("Anything")
        XCTAssertTrue(match)
    }

}
