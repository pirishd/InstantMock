//
//  TypesMockTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class SomeObject: NSObject { }


protocol TypesProtocol {
    func empty()
    func boolean(_ bool: Bool) -> Bool
    func integer(_ int: Int) -> Int
    func double(_ double: Double) -> Double
    func string(_ str: String) -> String
    func stringOpt(_ str: String) -> String?
    func object(_ obj: SomeObject) -> SomeObject?
    func set(_ set: Set<Int>) -> Set<String>
    func array(_ array: Array<Int>) -> Array<String>
    func dictionary(_ dictionary: Dictionary<String, Int>) -> Dictionary<String, Int>
}


final class TypesMock: Mock, TypesProtocol {

    func empty() {
        let _: Void = super.call()
    }

    func boolean(_ bool: Bool) -> Bool {
        return super.call(bool)!
    }

    func integer(_ int: Int) -> Int {
        return super.call(int)!
    }

    func integer64(_ int: Int64) -> Int64 {
        return super.call(int)!
    }

    func unsignedInteger(_ int: UInt) -> UInt {
        return super.call(int)!
    }

    func unsignedInteger64(_ int: UInt64) -> UInt64 {
        return super.call(int)!
    }

    func float(_ float: Float) -> Float {
        return super.call(float)!
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

    func object(_ obj: SomeObject) -> SomeObject? {
        return super.call(obj)
    }

    func set(_ set: Set<Int>) -> Set<String> {
        return super.call(set)!
    }

    func array(_ array: Array<Int>) -> Array<String> {
        return super.call(array)!
    }

    func date(_ date: Date) -> Date {
        return super.call(date)!
    }

    func dictionary(_ dictionary: Dictionary<String, Int>) -> Dictionary<String, Int> {
        return super.call(dictionary)!
    }

}


final class TypesMockTests: XCTestCase {

    private var mock: TypesMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = TypesMock(expectationFactory)
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
        self.mock.expect().call(self.mock.boolean(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.boolean(true)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testInt() {
        self.mock.expect().call(self.mock.integer(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.integer(12)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testInt64() {
        self.mock.expect().call(self.mock.integer64(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.integer64(12)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testUnsignedInt() {
        self.mock.expect().call(self.mock.unsignedInteger(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.unsignedInteger(12)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testUnsignedInt64() {
        self.mock.expect().call(self.mock.unsignedInteger64(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.unsignedInteger64(12)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testFloat() {
        self.mock.expect().call(self.mock.float(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.float(12.0)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testDouble() {
        self.mock.expect().call(self.mock.double(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.double(12.0)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testString() {

        self.mock.expect().call(self.mock.string(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.string("arg")

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testString_nil() {
        self.mock.expect().call(self.mock.stringOpt(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.stringOpt("arg")

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testObject() {
        let object = SomeObject()
        self.mock.expect().call(self.mock.object(Arg.eq(object)))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = mock.object(object)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testSet() {
        var set = Set<Int>()
        set.insert(1)

        self.mock.expect().call(self.mock.set(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.set(set)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testArray() {
        var array = Array<Int>()
        array.append(12)

        self.mock.expect().call(self.mock.array(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.array(array)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testDate() {
        self.mock.expect().call(self.mock.date(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.date(Date(timeIntervalSince1970: 1234))

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testDictionary() {
        var dict = Dictionary<String, Int>()
        dict["key"] = 12

        self.mock.expect().call(self.mock.dictionary(Arg.any()))

        self.mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = self.mock.dictionary(dict)

        self.mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }

}
