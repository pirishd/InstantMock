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
    private var argsConfig: ArgsConfiguration!


    override func setUp() {
        super.setUp()
        self.expectation = Expectation(withStub: Stub())
        self.argsConfig = ArgsConfiguration(with: [Any?]())
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
        var reason = self.expectation.reason
        XCTAssertNil(reason)

        let config = CallConfiguration(for: "Func", with: self.argsConfig)
        self.expectation.configuration = config

        reason = self.expectation.reason
        XCTAssertEqual(reason, "Func never called with expected args (none)")
    }


    func testReason_called() {
        let config = CallConfiguration(for: "Func", with: self.argsConfig)
        self.expectation.configuration = config

        self.expectation.handleCall([])
        var reason = self.expectation.reason
        XCTAssertNil(reason)

        // call a second time
        self.expectation.handleCall([])
        reason = self.expectation.reason
        XCTAssertNil(reason)
    }


    func testReason_withExpectedNumberOfCalls() {
        let config = CallConfiguration(for: "Func", with: self.argsConfig)
        self.expectation.configuration = config

        self.expectation.call(Int.any, numberOfTimes: 2)

        self.expectation.handleCall([])
        var reason = self.expectation.reason
        XCTAssertEqual(reason, "Func not called the expected number of times (1 out of 2) with expected args (none)")

        // call a second time
        self.expectation.handleCall([])
        reason = self.expectation.reason
        XCTAssertNil(reason)
    }


    func testVerify() {
        let assertion = AssertionMock()
        let expectation = Expectation(withStub: Stub(), assertion: assertion)
        let config = CallConfiguration(for: "Func", with: self.argsConfig)
        expectation.configuration = config

        let file: StaticString = "file"
        expectation.verify(file: file, line: 28)
        XCTAssertEqual(assertion.description, "Func never called with expected args (none)")
        XCTAssertEqual(assertion.file?.description, file.description)
        XCTAssertEqual(assertion.line, 28)
    }


}
