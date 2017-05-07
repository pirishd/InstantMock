//
//  ExpectationTests.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class ExpectationTests: XCTestCase {

    private var expectation: Expectation!


    override func setUp() {
        super.setUp()
        self.expectation = Expectation(withStub: Stub())
    }


    func testHandleCall() {
        let ret = self.expectation.handleCall([])
        XCTAssertNil(ret)
    }


    func testVerified_basic() {
        let verified = self.expectation.verified
        XCTAssertFalse(verified)
    }


    func testVerified_called() {
        self.expectation.handleCall([])
        var verified = self.expectation.verified
        XCTAssertTrue(verified)

        // call a second time
        self.expectation.handleCall([])
        verified = self.expectation.verified
        XCTAssertTrue(verified)
    }


    func testVerified_withExpectedNumberOfCalls() {
        self.expectation.call(Int.any, numberOfTimes: 2)

        self.expectation.handleCall([])
        var verified = self.expectation.verified
        XCTAssertFalse(verified)

        // call a second time
        self.expectation.handleCall([])
        verified = self.expectation.verified
        XCTAssertTrue(verified)
    }


    func testReason_basic() {
        let reason = self.expectation.reason
        XCTAssertNotNil(reason) // FIXME continue
    }

}
