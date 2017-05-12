//
//  ArgVerifyTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class ArgVerifyTests: XCTestCase {

    private var arg: ArgVerify<String>!

    override func setUp() {
        super.setUp()
        self.arg = ArgVerify({ str in true })
    }


    func testMatch_wrongType() {
        let match = self.arg.match(12)
        XCTAssertFalse(match)
    }


    func testMatch_success() {
        let match = self.arg.match("Hello")
        XCTAssertTrue(match)
    }

}
