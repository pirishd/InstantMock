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

    func testMatch() {
        let any = ArgAny("")
        let match = any.match("Anything")
        XCTAssertTrue(match)
    }
    
}
