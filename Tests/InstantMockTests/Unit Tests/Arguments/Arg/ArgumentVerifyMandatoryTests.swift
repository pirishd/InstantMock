//
//  ArgumentVerifyMandatoryTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class ArgumentVerifyMandatoryTests: XCTestCase {

    private var arg: ArgumentVerifyMandatoryImpl<String>!

    override func setUp() {
        super.setUp()
        self.arg = ArgumentVerifyMandatoryImpl({ str in true })
    }


    static var allTests = [
        ("testDescription", testDescription),
        ("testMatch_wrongType", testMatch_wrongType),
        ("testMatch_success", testMatch_success),
    ]


    func testDescription() {
        let desc = self.arg.description
        XCTAssertEqual(desc, "conditioned<(String) -> Bool>")
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
