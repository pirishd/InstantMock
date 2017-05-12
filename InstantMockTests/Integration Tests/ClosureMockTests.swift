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
    func someFunc(arg: String, closure: ((_ arg1: String, _ arg2: SomeClosureObject) -> Int))
}


class ClosureMock: Mock, ClosureProtocol {

    func someFunc(arg: String, closure: ((String, SomeClosureObject) -> Int)) {
        super.call(arg, closure)
    }

    override init(withExpectationFactory factory: ExpectationFactory) {
        super.init(withExpectationFactory: factory)
    }

}


class ClosureMockTests: XCTestCase {

    private var mock: ClosureMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = ClosureMock(withExpectationFactory: expectationFactory)
    }


    func testExpect() {

        self.mock.expect().call(self.mock.someFunc(
            arg: Arg<String>.any,
            closure: Arg<Closure>.any.withSignature() as ((String, SomeClosureObject) -> Int)
        ))

        self.mock.someFunc(arg: "Hello", closure: { (str, obj) -> Int in
            return 42
        })

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

    }
}

