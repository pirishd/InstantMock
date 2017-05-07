//
//  MockExpectationProtocolTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class DummyExpectationClass: MockDelegate, MockExpectation {

    private let mock = Mock()

    var it: Mock {
        return self.mock
    }

    @discardableResult
    func expect() -> Expectation {
        return it.expect()
    }

    func verify() {
        it.verify(file: #file, line: #line)
    }

}


class MockExpectationProtocolTests: XCTestCase {


    func testExpectation() {
        let dummy = DummyExpectationClass()
        dummy.expect()
    }


    func testVerify() {
        let dummy = DummyExpectationClass()
        dummy.verify()
    }

}
