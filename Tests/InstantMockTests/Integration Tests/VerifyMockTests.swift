//
//  VerifyMockTests.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


protocol VerifyProtocol {
    func someFunc(arg1: String, arg2: Int) -> String
    func someFuncOpt(arg1: String?, arg2: Int?) -> String?
}


final class VerifyMock: Mock, VerifyProtocol {

    func someFunc(arg1: String, arg2: Int) -> String {
        return super.call(arg1, arg2)!
    }

    func someFuncOpt(arg1: String?, arg2: Int?) -> String? {
        return super.call(arg1, arg2)
    }

}


final class VerifyMockTests: XCTestCase {

    private var mock: VerifyMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = VerifyMock(expectationFactory)
    }


    func testExpect_stringVerify() {

        mock.expect().call(mock.someFunc(arg1: Arg.verify({ str in str.hasPrefix("hello")}), arg2: Arg.any()))
        _ = mock.someFunc(arg1: "salut", arg2: 12)
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = mock.someFunc(arg1: "hello de lu", arg2: 12)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testStub_intVerify() {

        // configure two verifiers that are totally unjoined
        mock.expect().call(mock.someFunc(arg1: Arg.any(), arg2: Arg.verify({ val in val % 2 == 0 }))).andReturn("first")
        mock.expect().call(mock.someFunc(arg1: Arg.any(), arg2: Arg.verify({ val in val % 2 == 1 }))).andReturn("second")

        var ret = mock.someFunc(arg1: "anything", arg2: 12)
        XCTAssertEqual(ret, "first")
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        ret = mock.someFunc(arg1: "anything", arg2: 13)
        XCTAssertEqual(ret, "second")

        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_stringOpt() {
        mock.expect().call(mock.someFuncOpt(arg1: Arg.verify({ str in str == nil }),
                                            arg2: Arg.verify({ val in val == nil })))
        _ = mock.someFuncOpt(arg1: nil, arg2: 12)
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = mock.someFuncOpt(arg1: nil, arg2: nil)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }

}
