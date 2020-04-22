//
//  ArgumentVerifyOptionalTests.swift
//  InstantMock
//
//  Created by Patrick on 20/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class ArgumentVerifyOptionalTests: XCTestCase {

    private var arg: ArgumentVerifyOptionalImpl<String>!

    override func setUp() {
        super.setUp()
        self.arg = ArgumentVerifyOptionalImpl({ _ in true })
    }


    func testDescription() {
        let desc = self.arg.description
        XCTAssertEqual(desc, "conditioned<(Optional<String>) -> Bool>")
    }


    func testMatch_wrongType() {
        let match = self.arg.match(12)
        XCTAssertFalse(match)
    }


    func testMatch_success() {
        let match = self.arg.match("Hello")
        XCTAssertTrue(match)
    }


    func testMatch_success_nil() {
        let match = self.arg.match(nil)
        XCTAssertTrue(match)
    }

}
