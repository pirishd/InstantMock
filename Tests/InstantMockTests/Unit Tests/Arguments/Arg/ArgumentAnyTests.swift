//
//  ArgumentAnyTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class ArgumentAnyTests: XCTestCase {

    func testDescription() {
        let value = ArgumentAnyImpl("String")
        let desc = value.description
        XCTAssertEqual(desc, "any<String>")
    }


    func testMatch() {
        let any = ArgumentAnyImpl("")
        let match = any.match("Anything")
        XCTAssertTrue(match)
    }

}
