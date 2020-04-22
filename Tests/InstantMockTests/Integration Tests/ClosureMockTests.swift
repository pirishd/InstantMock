//
//  ClosureMockTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


final class SomeClosureObject {}


protocol ClosureProtocol {

    // mandatory and optional
    func someFunc(arg: String, closure: @escaping (_ arg1: String, _ arg2: SomeClosureObject) -> Int)
    func someFuncOpt(arg: String?, closure: ((_ arg1: String, _ arg2: SomeClosureObject) -> Int)?)

    // number of args
    func otherFuncNoArg(closure: @escaping () -> String)
    func otherFuncOneArg(closure: @escaping (String) -> String)
    func otherFuncTwoArgs(closure: @escaping (String, String) -> String)
    func otherFuncThreeArgs(closure: @escaping (String, String, String) -> String)
    func otherFuncFourArgs(closure: @escaping (String, String, String, String) -> String)
    func otherFuncFiveArgs(closure: @escaping (String, String, String, String, String) -> String)
}


final class ClosureMock: Mock, ClosureProtocol {

    func someFunc(arg: String, closure: @escaping (String, SomeClosureObject) -> Int) {
        super.call(arg, closure)
    }

    func someFuncOpt(arg: String?, closure: ((String, SomeClosureObject) -> Int)?) {
        super.call(arg, closure)
    }

    func otherFuncNoArg(closure: @escaping () -> String) {
        super.call(closure)
    }

    func otherFuncOneArg(closure: @escaping (String) -> String) {
        super.call(closure)
    }

    func otherFuncTwoArgs(closure: @escaping (String, String) -> String) {
        super.call(closure)
    }

    func otherFuncThreeArgs(closure: @escaping (String, String, String) -> String) {
        super.call(closure)
    }

    func otherFuncFourArgs(closure: @escaping (String, String, String, String) -> String) {
        super.call(closure)
    }

    func otherFuncFiveArgs(closure: @escaping (String, String, String, String, String) -> String) {
        super.call(closure)
    }

}


final class ClosureMockTests: XCTestCase {

    private var mock: ClosureMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = ClosureMock(expectationFactory)
    }


    func testExpect() {
        self.mock.expect().call(self.mock.someFunc(
            arg: Arg.any(),
            closure: Arg.closure()
        ))

        self.mock.someFunc(arg: "Hello", closure: { (_, _) -> Int in
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

        self.mock.someFuncOpt(arg: "Hello", closure: { (_, _) -> Int in
            return 42
        })

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_noArg() {
        self.mock.expect().call(self.mock.otherFuncNoArg(closure: Arg.closure()))

        self.mock.otherFuncNoArg(closure: { return "noarg" })

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_oneArg() {
        self.mock.expect().call(self.mock.otherFuncOneArg(closure: Arg.closure()))

        self.mock.otherFuncOneArg(closure: { _ in return "oneArg" })

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_twoArgs() {
        self.mock.expect().call(self.mock.otherFuncTwoArgs(closure: Arg.closure()))

        self.mock.otherFuncTwoArgs(closure: { _, _ in return "twoArgs" })

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_threeArgs() {
        self.mock.expect().call(self.mock.otherFuncThreeArgs(closure: Arg.closure()))

        self.mock.otherFuncThreeArgs(closure: { _, _, _ in return "threeArgs" })

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_fourArgs() {
        self.mock.expect().call(self.mock.otherFuncFourArgs(closure: Arg.closure()))

        self.mock.otherFuncFourArgs(closure: { _, _, _, _ in return "fourArgs" })

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_fiveArgs() {
        self.mock.expect().call(self.mock.otherFuncFiveArgs(closure: Arg.closure()))

        self.mock.otherFuncFiveArgs(closure: { _, _, _, _, _ in return "fiveArgs" })

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }

}
