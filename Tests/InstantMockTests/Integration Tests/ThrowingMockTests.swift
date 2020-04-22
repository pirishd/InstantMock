//
//  ThrowingMockTests.swift
//  InstantMock
//
//  Created by Patrick on 22/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


protocol ThrowingProtocol {
    func throwing() throws
    func throwingAndReturn() throws -> String
}


final class ThrowingMock: Mock, ThrowingProtocol {

    func throwing() throws {
        try super.callThrowing()
    }

    func throwingAndReturn() throws -> String {
        return try super.callThrowing()!
    }

}


final class ThrowingMockTests: XCTestCase {

    private enum ThrowingError: Error {
        case some
    }

    private var mock: ThrowingMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = ThrowingMock(expectationFactory)
    }


    func testStub_andThrow() {
        mock.stub().call(try! mock.throwing()).andThrow(ThrowingError.some)
        XCTAssertThrowsError(try mock.throwing()) { (error) -> Void in
            XCTAssertEqual(error as? ThrowingError, ThrowingError.some)
        }
    }


    func testStub_andThrow_returnNotThrow() {
        mock.stub().call(try! mock.throwingAndReturn()).andReturn("something")

        var ret: String?
        XCTAssertNoThrow(ret = try mock.throwingAndReturn())
        XCTAssertEqual(ret, "something")
    }


    func testStub_andThrow_returnThrow() {
        mock.stub().call(try! mock.throwingAndReturn()).andThrow(ThrowingError.some)
        XCTAssertThrowsError(try mock.throwingAndReturn()) { (error) -> Void in
            XCTAssertEqual(error as? ThrowingError, ThrowingError.some)
        }
    }

}
