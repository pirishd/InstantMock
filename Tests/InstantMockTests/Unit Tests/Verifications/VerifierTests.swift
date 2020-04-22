//
//  VerifierTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class VerifierTests: XCTestCase {

    private var verifier: VerifierImpl!


    override func setUp() {
        super.setUp()
        self.verifier = VerifierImpl()
    }


    func testEqual_bothNil() {
        let ret = self.verifier.equal(nil, to: nil)
        XCTAssertTrue(ret)
    }


    func testEqual_firstNil() {
        let ret = self.verifier.equal(nil, to: "something")
        XCTAssertFalse(ret)
    }


    func testEqual_secondNil() {
        let ret = self.verifier.equal("else", to: nil)
        XCTAssertFalse(ret)
    }


    func testEqual_strings() {
        let ret = self.verifier.equal("something", to: "something")
        XCTAssertTrue(ret)
    }


    func testEqual_stringsWithDifferentValues() {
        let ret = self.verifier.equal("something", to: "something else")
        XCTAssertFalse(ret)
    }


    func testEqual_floats() {
        let ret = self.verifier.equal(1.234 as Float, to: 1.234 as Float)
        XCTAssertTrue(ret)
    }


    func testEqual_int64s() {
        let ret = self.verifier.equal(Int64.max, to: Int64.max)
        XCTAssertTrue(ret)
    }


    func testEqual_uint64s() {
        let ret = self.verifier.equal(UInt64.max, to: UInt64.max)
        XCTAssertTrue(ret)
    }


    func testEqual_references() {
        let instance = DummyArgsMatcher()
        let ret = self.verifier.equal(instance, to: instance)
        XCTAssertTrue(ret)
    }


    func testMatch_differentReferences() {
        let instance = DummyArgsMatcher()
        let otherInstance = DummyArgsMatcher()

        let ret = self.verifier.equal(instance, to: otherInstance)
        XCTAssertFalse(ret)
    }


    func testMatch_closure_failure() {
        let closure: (() -> Void) = {}
        let closure2: ((String) -> Void) = { str in }

        let ret = self.verifier.equal(closure, to: closure2)
        XCTAssertFalse(ret)
    }


    func testEqualArray_success() {
        let array1 = ["val1", "val2"]
        let array2 = ["val1", "val2"]

        let ret = self.verifier.equalArray(array1, to: array2)
        XCTAssertTrue(ret)
    }


    func testEqualArray_failure() {
        let array1 = ["val1", "val2"]
        var array2 = ["val1"]

        var ret = self.verifier.equalArray(array1, to: array2)
        XCTAssertFalse(ret)

        array2 = ["val1", "val3"]
        ret = self.verifier.equalArray(array1, to: array2)
        XCTAssertFalse(ret)
    }


    func testVoid() {
        let void1: Void = ()
        let void2: Void = ()

        var ret = self.verifier.equal(void1, to: "bad")
        XCTAssertFalse(ret)

        ret = self.verifier.equal(void1, to: void2)
        XCTAssertTrue(ret)
    }


    func testTypes_success() {
        let type1 = String.self
        let type2 = String.self

        let ret = self.verifier.equal(type1, to: type2)
        XCTAssertTrue(ret)
    }


    func testTypes_failure() {
        let type1 = String.self
        let type2 = Bool.self
        let str = "Hello"

        var ret = self.verifier.equal(type1, to: str)
        XCTAssertFalse(ret)

        ret = self.verifier.equal(type1, to: type2)
        XCTAssertFalse(ret)
    }


    func testTuples_success() {
        let tuple1 = (43)
        let tuple2 = (43)
        var ret = self.verifier.equal(tuple1, to: tuple2)
        XCTAssertTrue(ret)

        let tuple3 = (43, "toto")
        let tuple4 = (43, "toto")
        ret = self.verifier.equal(tuple3, to: tuple4)
        XCTAssertTrue(ret)

        let tuple5 = (43, "toto", 12)
        let tuple6 = (43, "toto", 12)
        ret = self.verifier.equal(tuple5, to: tuple6)
        XCTAssertTrue(ret)

        let tuple7 = (43, "toto", 12, "rt")
        let tuple8 = (43, "toto", 12, "rt")
        ret = self.verifier.equal(tuple7, to: tuple8)
        XCTAssertTrue(ret)

        let tuple9 = (43, "toto", 12, "rt", "n")
        let tuple10 = (43, "toto", 12, "rt", "n")
        ret = self.verifier.equal(tuple9, to: tuple10)
        XCTAssertTrue(ret)
    }


    func testTuples_failure() {
        let tuple1 = (43, "toto", "az")
        let tuple2 = (43, "toto", "bz")

        var ret = self.verifier.equal(tuple1, to: tuple2)
        XCTAssertFalse(ret)

        let tuple3 = (43, "toto", "az", 12)

        ret = self.verifier.equal(tuple1, to: tuple3)
        XCTAssertFalse(ret)
    }

}
