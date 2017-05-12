//
//  ArgCaptureTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


class ArgCaptureTests: XCTestCase {

    func testMatch() {
        let any = ArgCapture("")
        let match = any.match("Anything")
        XCTAssertTrue(match)
    }

}
