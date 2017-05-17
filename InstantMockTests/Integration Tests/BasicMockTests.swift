//
//  BasicMockTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


protocol BasicProtocol {
    func basic(arg1: String, arg2: Int) -> String
    func basicOpt(arg1: String?, arg2: Int?) -> String?
}


class BasicMock: Mock, BasicProtocol {

    func basic(arg1: String, arg2: Int) -> String {
        return super.call(arg1, arg2)!
    }

    func basicOpt(arg1: String?, arg2: Int?) -> String? {
        return super.call(arg1, arg2)
    }

}



class BasicMockTests: XCTestCase {

    private var mock: BasicMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = BasicMock(expectationFactory)
    }


    func testExpect() {
        mock.expect().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg<Int>.any))
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = mock.basic(arg1: "Hello", arg2: 2)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_optional_nil() {
        mock.expect().call(mock.basicOpt(arg1: Arg.eq(nil), arg2: Arg<Int>.any))

        _ = mock.basicOpt(arg1: nil, arg2: nil)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_optional_nonnil() {
        mock.expect().call(mock.basicOpt(arg1: Arg.eq("Hello"), arg2: Arg<Int>.any))

        _ = mock.basicOpt(arg1: "Hello", arg2: 12)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_numberOfTimes() {
        mock.expect().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg<Int>.any), numberOfTimes: 2)
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = mock.basic(arg1: "Hello", arg2: 2)
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = mock.basic(arg1: "Hello", arg2: 3)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testStub() {
        var callbackValue: String?
        mock.stub().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg<Int>.any)).andReturn("string").andDo { _ in
            callbackValue = "something"
        }

        let ret = mock.basic(arg1: "Hello", arg2: 2)
        XCTAssertEqual(ret, "string")
        XCTAssertEqual(callbackValue, "something")
    }


    func testSeveralStubs() {

        mock.stub().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg<Int>.any)).andReturn("string")
        mock.stub().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg.eq(2))).andReturn("string2")

        let ret = mock.basic(arg1: "Hello", arg2: 2)
        XCTAssertEqual(ret, "string2")
    }


    func testExpectAndStub() {

        var callbackValue: String?
        mock.expect().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg<Int>.any)).andReturn("string").andDo {_ in
            callbackValue = "something"
        }

        let ret = mock.basic(arg1: "Hello", arg2: 2)
        XCTAssertEqual(ret, "string")
        XCTAssertEqual(callbackValue, "something")
    }


    func testStub_returnAndDo() {

        var ret = ""
        mock.stub().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg<Int>.any)).andReturn(closure: { _ in
            ret = ret + "a"
            return ret
        })

        var retValue = mock.basic(arg1: "Hello", arg2: 2)
        XCTAssertEqual(retValue, "a")

        retValue = mock.basic(arg1: "Hello", arg2: 2)
        XCTAssertEqual(retValue, "aa")
    }

}
