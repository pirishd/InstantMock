//
//  CaptureMockTests.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class SomeCaptureObject {}

protocol CaptureProtocol {

    // basic cases
    func someFunc(arg1: String, arg2: Int) -> String
    func someFunc(arg: String, closure: @escaping ((Int, SomeCaptureObject) -> String))

    // number of args for closure
    func otherFuncNoArg(closure: @escaping () -> Int)
    func otherFuncOneArg(closure: @escaping (Int) -> Int)
    func otherFuncTwoArgs(closure: @escaping (Int, Int) -> Int)
    func otherFuncThreeArgs(closure: @escaping (Int, Int, Int) -> Int)
    func otherFuncFourArgs(closure: @escaping (Int, Int, Int, Int) -> Int)
    func otherFuncFiveArgs(closure: @escaping (Int, Int, Int, Int, Int) -> Int)
}


class CaptureMock: Mock, CaptureProtocol {

    func someFunc(arg1: String, arg2: Int) -> String {
        return super.call(arg1, arg2)!
    }

    func someFunc(arg: String, closure: @escaping ((Int, SomeCaptureObject) -> String)) {
        super.call(arg, closure)
    }

    func otherFuncNoArg(closure: @escaping () -> Int) {
        super.call(closure)
    }

    func otherFuncOneArg(closure: @escaping (Int) -> Int) {
        super.call(closure)
    }

    func otherFuncTwoArgs(closure: @escaping (Int, Int) -> Int) {
        super.call(closure)
    }

    func otherFuncThreeArgs(closure: @escaping (Int, Int, Int) -> Int) {
        super.call(closure)
    }

    func otherFuncFourArgs(closure: @escaping (Int, Int, Int, Int) -> Int) {
        super.call(closure)
    }

    func otherFuncFiveArgs(closure: @escaping (Int, Int, Int, Int, Int) -> Int) {
        super.call(closure)
    }

}



class CaptureMockTests: XCTestCase {

    private var mock: CaptureMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = CaptureMock(expectationFactory)
    }


    static var allTests = [
        ("testExpect_capture", testExpect_capture),
        ("testExpect_capture_closure", testExpect_capture_closure),
        ("testExpect_capture_closure_noArg", testExpect_capture_closure_noArg),
        ("testExpect_capture_closure_oneArg", testExpect_capture_closure_oneArg),
        ("testExpect_capture_closure_twoArgs", testExpect_capture_closure_twoArgs),
        ("testExpect_capture_closure_threeArgs", testExpect_capture_closure_threeArgs),
        ("testExpect_capture_closure_fourArgs", testExpect_capture_closure_fourArgs),
        ("testExpect_capture_closure_fiveArgs", testExpect_capture_closure_fiveArgs),
    ]


    func testExpect_capture() {

        let captureStr = ArgumentCaptor<String>()
        let captureInt = ArgumentCaptor<Int>()
        mock.expect().call(mock.someFunc(arg1: captureStr.capture(), arg2: captureInt.capture()))

        _ = mock.someFunc(arg1: "Paris", arg2: 32)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertEqual(captureStr.value, "Paris")
        XCTAssertEqual(captureInt.value, 32)

        XCTAssertEqual(captureStr.allValues.first!, "Paris")
        XCTAssertEqual(captureInt.allValues.first!, 32)

        _ = mock.someFunc(arg1: "London", arg2: 42)
        XCTAssertEqual(captureStr.value, "London")
        XCTAssertEqual(captureInt.value, 42)

        XCTAssertEqual(captureStr.allValues.flatMap {$0}, ["Paris", "London"])
        XCTAssertEqual(captureInt.allValues.flatMap {$0}, [32, 42])
    }


    func testExpect_capture_closure() {

        let captor = ArgumentClosureCaptor<(Int, SomeCaptureObject) -> String>()
        mock.expect().call(mock.someFunc(arg: Arg.any(), closure: captor.capture()))

        mock.someFunc(arg: "Hello") { (num, obj) -> String in
            return "\(num)"
        }

        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        let ret = captor.value!(2, SomeCaptureObject())
        XCTAssertEqual(ret, "2")
        XCTAssertEqual(captor.allValues.count, 1)
    }


    func testExpect_capture_closure_noArg() {
        let captor = ArgumentClosureCaptor<() -> Int>()
        mock.expect().call(mock.otherFuncNoArg(closure: captor.capture()))

        mock.otherFuncNoArg { return 42 }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        let ret = captor.value!()
        XCTAssertEqual(ret, 42)
        XCTAssertEqual(captor.allValues.count, 1)
    }


    func testExpect_capture_closure_oneArg() {
        let captor = ArgumentClosureCaptor<(Int) -> Int>()
        mock.expect().call(mock.otherFuncOneArg(closure: captor.capture()))

        mock.otherFuncOneArg { num in return num }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        let ret = captor.value!(3)
        XCTAssertEqual(ret, 3)
        XCTAssertEqual(captor.allValues.count, 1)
    }


    func testExpect_capture_closure_twoArgs() {
        let captor = ArgumentClosureCaptor<(Int, Int) -> Int>()
        mock.expect().call(mock.otherFuncTwoArgs(closure: captor.capture()))

        mock.otherFuncTwoArgs { num1, num2 in return num1 + num2 }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        let ret = captor.value!(3, 5)
        XCTAssertEqual(ret, 8)
        XCTAssertEqual(captor.allValues.count, 1)
    }


    func testExpect_capture_closure_threeArgs() {
        let captor = ArgumentClosureCaptor<(Int, Int, Int) -> Int>()
        mock.expect().call(mock.otherFuncThreeArgs(closure: captor.capture()))

        mock.otherFuncThreeArgs { num1, num2, num3 in return num1 + num2 + num3 }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        let ret = captor.value!(1, 2, 3)
        XCTAssertEqual(ret, 6)
        XCTAssertEqual(captor.allValues.count, 1)
    }


    func testExpect_capture_closure_fourArgs() {
        let captor = ArgumentClosureCaptor<(Int, Int, Int, Int) -> Int>()
        mock.expect().call(mock.otherFuncFourArgs(closure: captor.capture()))

        mock.otherFuncFourArgs { num1, num2, num3, num4 in return num1 + num2 + num3 + num4 }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        let ret = captor.value!(1, 2, 3, 4)
        XCTAssertEqual(ret, 10)
        XCTAssertEqual(captor.allValues.count, 1)
    }


    func testExpect_capture_closure_fiveArgs() {
        let captor = ArgumentClosureCaptor<(Int, Int, Int, Int, Int) -> Int>()
        mock.expect().call(mock.otherFuncFiveArgs(closure: captor.capture()))

        mock.otherFuncFiveArgs { num1, num2, num3, num4, num5 in return num1 + num2 + num3 + num4 + num5 }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        let ret = captor.value!(1, 2, 3, 4, 5)
        XCTAssertEqual(ret, 15)
        XCTAssertEqual(captor.allValues.count, 1)
    }

}

