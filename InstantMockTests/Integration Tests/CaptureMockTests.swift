//
//  CaptureMockTests.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


protocol CaptureProtocol {
    func someFunc(arg1: String, arg2: Int) -> String
}


class CaptureMock: Mock, CaptureProtocol {

    func someFunc(arg1: String, arg2: Int) -> String {
        return super.call(arg1, arg2)!
    }

    override init(withExpectationFactory factory: ExpectationFactory) {
        super.init(withExpectationFactory: factory)
    }

}



class CaptureMockTests: XCTestCase {

    private var mock: CaptureMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = CaptureMock(withExpectationFactory: expectationFactory)
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

        XCTAssertEqual(captureStr.allValues.flatMap {$0}, ["Paris", "London"])
        XCTAssertEqual(captureInt.allValues.flatMap {$0}, [32, 42])
    }

}
