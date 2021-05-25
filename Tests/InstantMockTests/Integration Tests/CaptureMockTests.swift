//
//  CaptureMockTests.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class SomeCaptureObject {}

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

    // number of args for closure that throw
    func otherFuncNoArgThrows(closure: @escaping () throws -> Int)
    func otherFuncOneArgThrows(closure: @escaping (Int) throws -> Int)
    func otherFuncTwoArgsThrows(closure: @escaping (Int, Int) throws -> Int)
    func otherFuncThreeArgsThrows(closure: @escaping (Int, Int, Int) throws -> Int)
    func otherFuncFourArgsThrows(closure: @escaping (Int, Int, Int, Int) throws -> Int)
    func otherFuncFiveArgsThrows(closure: @escaping (Int, Int, Int, Int, Int) throws -> Int)
}


final class CaptureMock: Mock, CaptureProtocol {

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

    func otherFuncNoArgThrows(closure: @escaping () throws -> Int) {
        super.call(closure)
    }

    func otherFuncOneArgThrows(closure: @escaping (Int) throws -> Int) {
        super.call(closure)
    }

    func otherFuncTwoArgsThrows(closure: @escaping (Int, Int) throws -> Int) {
        super.call(closure)
    }

    func otherFuncThreeArgsThrows(closure: @escaping (Int, Int, Int) throws -> Int) {
        super.call(closure)
    }

    func otherFuncFourArgsThrows(closure: @escaping (Int, Int, Int, Int) throws -> Int) {
        super.call(closure)
    }

    func otherFuncFiveArgsThrows(closure: @escaping (Int, Int, Int, Int, Int) throws -> Int) {
        super.call(closure)
    }

}


final class CaptureMockTests: XCTestCase {

    private var mock: CaptureMock!
    private var assertionMock: AssertionMock!


    enum DummyError: Error {
        case dummy
    }


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = CaptureMock(expectationFactory)
    }


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

        XCTAssertEqual(captureStr.allValues.compactMap {$0}, ["Paris", "London"])
        XCTAssertEqual(captureInt.allValues.compactMap {$0}, [32, 42])
    }


    func testExpect_capture_closure() {

        let captor = ArgumentClosureCaptor<(Int, SomeCaptureObject) -> String>()
        mock.expect().call(mock.someFunc(arg: Arg.any(), closure: captor.capture()))

        mock.someFunc(arg: "Hello") { (num, _) -> String in
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


    func testExpect_capture_closure_noArg_throws() {
        let captor = ArgumentClosureCaptor<() throws -> Int>()
        mock.expect().call(mock.otherFuncNoArgThrows(closure: captor.capture()))

        mock.otherFuncNoArgThrows { throw DummyError.dummy }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        do {
            let ret = try captor.value!()
            XCTAssertNil(ret)
        } catch DummyError.dummy {
        } catch {
            XCTFail("unexpected error=\(error)")
        }
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


    func testExpect_capture_closure_oneArg_throws() {
        let captor = ArgumentClosureCaptor<(Int) throws -> Int>()
        mock.expect().call(mock.otherFuncOneArgThrows(closure: captor.capture()))

        mock.otherFuncOneArgThrows { _ in throw DummyError.dummy }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        do {
            let ret = try captor.value!(3)
            XCTAssertNil(ret)
        } catch DummyError.dummy {
        } catch {
            XCTFail("unexpected error=\(error)")
        }
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


    func testExpect_capture_closure_twoArgs_throws() {
        let captor = ArgumentClosureCaptor<(Int, Int) throws -> Int>()
        mock.expect().call(mock.otherFuncTwoArgsThrows(closure: captor.capture()))

        mock.otherFuncTwoArgsThrows { _, _ in throw DummyError.dummy }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        do {
            let ret = try captor.value!(3, 5)
            XCTAssertNil(ret)
        } catch DummyError.dummy {
        } catch {
            XCTFail("unexpected error=\(error)")
        }
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


    func testExpect_capture_closure_threeArgs_throws() {
        let captor = ArgumentClosureCaptor<(Int, Int, Int) throws -> Int>()
        mock.expect().call(mock.otherFuncThreeArgsThrows(closure: captor.capture()))

        mock.otherFuncThreeArgsThrows { _, _, _ in throw DummyError.dummy }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        do {
            let ret = try captor.value!(1, 2, 3)
            XCTAssertNil(ret)
        } catch DummyError.dummy {
        } catch {
            XCTFail("unexpected error=\(error)")
        }
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


    func testExpect_capture_closure_fourArgs_throws() {
        let captor = ArgumentClosureCaptor<(Int, Int, Int, Int) throws -> Int>()
        mock.expect().call(mock.otherFuncFourArgsThrows(closure: captor.capture()))

        mock.otherFuncFourArgsThrows { _, _, _, _ in throw DummyError.dummy }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        do {
            let ret = try captor.value!(1, 2, 3, 4)
            XCTAssertNil(ret)
        } catch DummyError.dummy {
        } catch {
            XCTFail("unexpected error=\(error)")
        }
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


    func testExpect_capture_closure_fiveArgs_throws() {
        let captor = ArgumentClosureCaptor<(Int, Int, Int, Int, Int) throws -> Int>()
        mock.expect().call(mock.otherFuncFiveArgsThrows(closure: captor.capture()))

        mock.otherFuncFiveArgsThrows { _, _, _, _, _ in throw DummyError.dummy }
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        XCTAssertNotNil(captor.value)
        do {
            let ret = try captor.value!(1, 2, 3, 4, 5)
            XCTAssertNil(ret)
        } catch DummyError.dummy {
        } catch {
            XCTFail("unexpected error=\(error)")
        }
        XCTAssertEqual(captor.allValues.count, 1)
    }

}
