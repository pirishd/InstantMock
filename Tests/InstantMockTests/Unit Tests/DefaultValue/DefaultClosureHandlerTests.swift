//
//  DefaultClosureHandlerTests.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class DefaultClosureHandlerTests: XCTestCase {

    static var allTests = [
        ("testIt", testIt),
    ]

    func testIt() {
        let closure = DefaultClosureHandler.it() as (String) -> Int
        XCTAssertNotNil(closure)
    }

}

