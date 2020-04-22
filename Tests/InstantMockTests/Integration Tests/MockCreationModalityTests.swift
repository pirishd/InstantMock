//
//  MockCreationModalityTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


protocol SomeProtocol {
    func someFunc(arg1: String, arg2: Int) -> String
}


final class InheritanceMock: Mock, SomeProtocol {

    func someFunc(arg1: String, arg2: Int) -> String {
        return super.call(arg1, arg2)!
    }

}


final class DelegateItMock: Any, MockDelegate, SomeProtocol {

    private let expectationFactory: ExpectationFactory
    private let mock: Mock!

    init(withExpectationFactory factory: ExpectationFactory) {
        self.expectationFactory = factory
        self.mock = Mock(expectationFactory)
    }

    var it: Mock {
        return self.mock
    }

    func someFunc(arg1: String, arg2: Int) -> String {
        return self.mock.call(arg1, arg2)!
    }

}


final class DelegateFullMock: Any, MockDelegate, MockExpectation, MockStub, SomeProtocol {

    private let expectationFactory: ExpectationFactory
    private let mock: Mock!

    init(withExpectationFactory factory: ExpectationFactory) {
        self.expectationFactory = factory
        self.mock = Mock(expectationFactory)
    }


    var it: Mock {
        return self.mock
    }

    func expect() -> Expectation {
        return self.mock.expect()
    }

    func reject() -> Expectation {
        return self.mock.reject()
    }

    func verify(file: StaticString? = #file, line: UInt? = #line) {
        self.mock.verify(file: file, line: line)
    }

    func stub() -> Stub {
        return self.mock.stub()
    }

    func someFunc(arg1: String, arg2: Int) -> String {
        return self.mock.call(arg1, arg2)!
    }

}


final class MockCreationModalityTests: XCTestCase {

    private var assertionMock: AssertionMock!
    private var expectationFactory: ExpectationFactoryMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        self.expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
    }


    func testExpect_inheritanceMock() {
        let mock = InheritanceMock(self.expectationFactory)
        mock.expect().call(mock.someFunc(arg1: Arg.eq("Hello"), arg2: Arg.any()))

        _ = mock.someFunc(arg1: "Hello", arg2: 2)

        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_delegateItMock() {
        let mock = DelegateItMock(withExpectationFactory: self.expectationFactory)
        mock.it.expect().call(mock.someFunc(arg1: Arg.eq("Hello"), arg2: Arg.any()))

        _ = mock.someFunc(arg1: "Hello", arg2: 2)

        mock.it.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_delegateFullMock() {
        let mock = DelegateFullMock(withExpectationFactory: self.expectationFactory)
        mock.expect().call(mock.someFunc(arg1: Arg.eq("Hello"), arg2: Arg.any()))

        _ = mock.someFunc(arg1: "Hello", arg2: 2)

        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }

}
