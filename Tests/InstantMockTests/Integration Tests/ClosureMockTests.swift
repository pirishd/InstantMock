//
//  ClosureMockTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


class SomeClosureObject {}


protocol ClosureProtocol {
    func someFunc(arg: String, closure: (_ arg1: String, _ arg2: SomeClosureObject) -> Int)
    func someFuncOpt(arg: String?, closure: ((_ arg1: String, _ arg2: SomeClosureObject) -> Int)?)
}


class ClosureMock: Mock, ClosureProtocol {

    func someFunc(arg: String, closure: (String, SomeClosureObject) -> Int) {
        super.call(arg, closure)
    }

    func someFuncOpt(arg: String?, closure: ((String, SomeClosureObject) -> Int)?) {
        super.call(arg, closure)
    }

}


class ClosureMockTests: XCTestCase {

    private var mock: ClosureMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = ClosureMock(expectationFactory)
    }


    static var allTests = [
        ("testExpect", testExpect),
        ("testExpect_optionalNil", testExpect_optionalNil),
        ("testExpect_optionalNotNil", testExpect_optionalNotNil),
    ]


    func testExpect() {

        self.mock.expect().call(self.mock.someFunc(
            arg: Arg.any(),
            closure: Arg.closure()
        ))

        self.mock.someFunc(arg: "Hello", closure: { (str, obj) -> Int in
            return 42
        })

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

    }


    func testExpect_optionalNil() {

        self.mock.expect().call(self.mock.someFuncOpt(
            arg: Arg.any(),
            closure: Arg.closure()
        ))

        self.mock.someFuncOpt(arg: "Hello", closure: nil)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

    }


    func testExpect_optionalNotNil() {

        self.mock.expect().call(self.mock.someFuncOpt(
            arg: Arg.any(),
            closure: Arg.closure()
        ))

        self.mock.someFuncOpt(arg: "Hello", closure: { (str, obj) -> Int in
            return 42
        })

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }

}

