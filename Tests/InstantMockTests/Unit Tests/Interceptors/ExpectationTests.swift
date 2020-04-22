//
//  ExpectationTests.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class ExpectationTests: XCTestCase {

    private var expectation: Expectation!
    private var argsConfig: ArgumentsConfiguration!


    override func setUp() {
        super.setUp()
        self.expectation = Expectation(withStub: Stub())
        self.argsConfig = ArgumentsConfiguration([Argument]())
    }


    func testHandleCall() {
        let ret = try! self.expectation.handleCall([])
        XCTAssertNil(ret)
    }


    func testVerified_basic() {
        let verified = self.expectation.verified
        XCTAssertFalse(verified)
    }


    func testVerified_called() {
        try! self.expectation.handleCall([])
        var verified = self.expectation.verified
        XCTAssertTrue(verified)

        // call a second time
        try! self.expectation.handleCall([])
        verified = self.expectation.verified
        XCTAssertTrue(verified)
    }


    func testVerified_withExpectedNumberOfCalls() {
        self.expectation.call(Int.any, count: 2)

        try! self.expectation.handleCall([])
        var verified = self.expectation.verified
        XCTAssertFalse(verified)

        // call a second time
        try! self.expectation.handleCall([])
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

        try! self.expectation.handleCall([])
        var reason = self.expectation.reason
        XCTAssertNil(reason)

        // call a second time
        try! self.expectation.handleCall([])
        reason = self.expectation.reason
        XCTAssertNil(reason)
    }


    func testReason_withExpectedNumberOfCalls() {
        let config = CallConfiguration(for: "Func", with: self.argsConfig)
        self.expectation.configuration = config

        self.expectation.call(Int.any, count: 2)

        try! self.expectation.handleCall([])
        var reason = self.expectation.reason
        XCTAssertEqual(reason, "Func not called the expected number of times (1 out of 2) with expected args (none)")

        // call a second time
        try! self.expectation.handleCall([])
        reason = self.expectation.reason
        XCTAssertNil(reason)
    }


    func testReason_rejected_basic() {
        let rejection = Expectation(withStub: Stub(), reject: true)
        var reason = rejection.reason
        XCTAssertNil(reason)

        let config = CallConfiguration(for: "Func", with: self.argsConfig)
        rejection.configuration = config

        try! rejection.handleCall([])

        reason = rejection.reason
        XCTAssertEqual(reason, "Func called with unexpected args (none)")
    }


    func testReason_rejected_notCalled() {
        let rejection = Expectation(withStub: Stub(), reject: true)
        var reason = rejection.reason
        XCTAssertNil(reason)

        let config = CallConfiguration(for: "Func", with: self.argsConfig)
        rejection.configuration = config

        reason = rejection.reason
        XCTAssertNil(reason)
    }


    func testReason_rejected_withExpectedNumberOfCalls() {
        let rejection = Expectation(withStub: Stub(), reject: true)

        let config = CallConfiguration(for: "Func", with: self.argsConfig)
        rejection.configuration = config

        rejection.call(Int.any, count: 2)

        try! rejection.handleCall([])
        var reason = rejection.reason
        XCTAssertNil(reason)

        // call a second time
        try! rejection.handleCall([])
        reason = rejection.reason
        XCTAssertEqual(reason, "Func called a wrong number of times (2) with unexpected args (none)")
    }


    func testVerify_accepted() {
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


    func testVerify_rejected() {
        let assertion = AssertionMock()
        let rejection = Expectation(withStub: Stub(), reject: true, assertion: assertion)
        let config = CallConfiguration(for: "Func", with: self.argsConfig)
        rejection.configuration = config

        try! rejection.handleCall([])

        let file: StaticString = "file"
        rejection.verify(file: file, line: 28)
        XCTAssertEqual(assertion.description, "Func called with unexpected args (none)")
        XCTAssertEqual(assertion.file?.description, file.description)
        XCTAssertEqual(assertion.line, 28)
    }


}
