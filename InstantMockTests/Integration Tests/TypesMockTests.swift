//
//  TypesMockTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


protocol TypesProtocol {
    func empty()
    func boolean(_ bool: Bool) -> Bool
    func integer(_ int: Int) -> Int
    func double(_ double: Double) -> Double
    func string(_ str: String) -> String
    func stringOpt(_ str: String) -> String?
}


class TypesMock: Mock, TypesProtocol {

    func empty() {
        let _: Void = super.call()
    }

    func boolean(_ bool: Bool) -> Bool {
        return super.call(bool)!
    }

    func integer(_ int: Int) -> Int {
        return super.call(int)!
    }

    func double(_ double: Double) -> Double {
        return super.call(double)!
    }

    func string(_ str: String) -> String {
        return super.call(str)!
    }

    func stringOpt(_ str: String) -> String? {
        return super.call(str)
    }

    override init(withExpectationFactory factory: ExpectationFactory) {
        super.init(withExpectationFactory: factory)
    }

}


class TypesMockTests: XCTestCase {

    private var mock: TypesMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = TypesMock(withExpectationFactory: expectationFactory)
    }


    func testEmpty() {
        self.mock.expect().call(self.mock.empty())

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        self.mock.empty()

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testBool() {
        self.mock.expect().call(self.mock.boolean(Bool.any))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        let _ = self.mock.boolean(true)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testInt() {
        self.mock.expect().call(self.mock.integer(Int.any))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        let _ = self.mock.integer(12)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testDouble() {
        self.mock.expect().call(self.mock.double(Double.any))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        let _ = self.mock.double(12.0)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testString() {
        self.mock.expect().call(self.mock.string(String.any))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        let _ = self.mock.string("arg")

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testString_nil() {
        self.mock.expect().call(self.mock.stringOpt(String.any))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        let _ = self.mock.stringOpt("arg")

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }

}
