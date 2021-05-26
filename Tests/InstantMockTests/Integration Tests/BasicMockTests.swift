//
//  BasicMockTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock



protocol BasicProtocol {
    var prop: String { get set }
    func basic(arg1: String, arg2: Int) -> String
    func basicOpt(arg1: String?, arg2: Int?) -> String?
    func basicType(type: String.Type)
    func basicTuple(tuple: (String, Int?))
}



final class BasicMock: Mock, BasicProtocol {

    var prop: String {
        get { return super.call()! }
        set { super.call(newValue) }
    }

    func basic(arg1: String, arg2: Int) -> String {
        return super.call(arg1, arg2)!
    }

    func basicOpt(arg1: String?, arg2: Int?) -> String? {
        return super.call(arg1, arg2)
    }

    func basicType(type: String.Type) {
        super.call(type)
    }

    func basicTuple(tuple: (String, Int?)) {
        super.call(tuple)
    }

}



final class BasicMockTests: XCTestCase {

    private var mock: BasicMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = BasicMock(expectationFactory)
    }


    func testExpect() {
        mock.expect().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg.any()))
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = mock.basic(arg1: "Hello", arg2: 2)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_optional_nil() {
        mock.expect().call(mock.basicOpt(arg1: Arg.eq(nil), arg2: Arg.any()))

        _ = mock.basicOpt(arg1: nil, arg2: nil)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_optional_nonnil() {
        mock.expect().call(mock.basicOpt(arg1: Arg.eq("Hello"), arg2: Arg.any()))

        _ = mock.basicOpt(arg1: "Hello", arg2: 12)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_count() {
        mock.expect().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg.any()), count: 2)
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = mock.basic(arg1: "Hello", arg2: 2)
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        _ = mock.basic(arg1: "Hello", arg2: 3)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_count_zero() {
        mock.expect().call(mock.basic(arg1: Arg.eq("Hello2"), arg2: Arg.any()), count: 0)
        _ = mock.basic(arg1: "Hello", arg2: 3)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_type() {
        mock.expect().call(mock.basicType(type: Arg.eq(String.self)))
        mock.basicType(type: String.self)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpect_tuple() {
        mock.expect().call(mock.basicTuple(tuple: Arg.eq(("toto", 42))))
        mock.basicTuple(tuple: ("toto", 42))
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testReject() {
        mock.reject().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg.any()))
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        _ = mock.basic(arg1: "Hello", arg2: 2)
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)
    }


    func testReject_count() {
        mock.reject().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg.any()), count: 2)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        _ = mock.basic(arg1: "Hello", arg2: 2)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)

        _ = mock.basic(arg1: "Hello", arg2: 3)
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)
    }


    func testStub() {
        var callbackValue: String?
        mock.stub().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg.any())).andReturn("string").andDo { _ in
            callbackValue = "something"
        }

        let ret = mock.basic(arg1: "Hello", arg2: 2)
        XCTAssertEqual(ret, "string")
        XCTAssertEqual(callbackValue, "something")
    }


    func testSeveralStubs() {

        mock.stub().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg.any())).andReturn("string")
        mock.stub().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg.eq(2))).andReturn("string2")

        let ret = mock.basic(arg1: "Hello", arg2: 2)
        XCTAssertEqual(ret, "string2")
    }


    func testExpectAndStub() {

        var callbackValue: String?
        mock.expect().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg.any())).andReturn("string").andDo {_ in
            callbackValue = "something"
        }

        let ret = mock.basic(arg1: "Hello", arg2: 2)
        XCTAssertEqual(ret, "string")
        XCTAssertEqual(callbackValue, "something")
    }


    func testStub_returnAndDo() {

        var ret = ""
        mock.stub().call(mock.basic(arg1: Arg.eq("Hello"), arg2: Arg.any())).andReturn(closure: { _ in
            ret = ret + "a"
            return ret
        })

        var retValue = mock.basic(arg1: "Hello", arg2: 2)
        XCTAssertEqual(retValue, "a")

        retValue = mock.basic(arg1: "Hello", arg2: 2)
        XCTAssertEqual(retValue, "aa")
    }


    func testExpectProperty_value() {
        mock.expect().call(mock.property.set(mock.prop, value: Arg.eq("test")))
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        mock.prop = "test"
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testExpectProperty_any() {
        mock.expect().call(mock.property.set(mock.prop, value: Arg.any()))
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        mock.prop = "test"
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    // test dedicated to making sure there is no mixup between property setter and getter
    func testExpectProperty_value_setter_getter() {
        mock.expect().call(mock.property.set(mock.prop, value: Arg.eq("test")))
        mock.expect().call(mock.prop).andReturn("test2")

        mock.prop = "test"
        let ret = mock.prop

        mock.verify()
        XCTAssertEqual(ret, "test2")
        XCTAssertTrue(self.assertionMock.succeeded)
    }


    func testResetExpectations() {
        mock.reject().call(mock.basic(arg1: Arg.any(), arg2: Arg.any()))
        mock.resetExpectations()
        _ = mock.basic(arg1: "", arg2: 0)
        mock.verify()
    }


    func testResetStubs() {
        mock.stub().call(mock.basic(arg1: Arg.any(), arg2: Arg.any())).andReturn("string")
        mock.resetStubs()
        let ret = mock.basic(arg1: "", arg2: 2)
        XCTAssertNotEqual(ret, "string")
    }


    // See ticket #103
    func testExpect_missingArgumentStorageFlushAfterRegistration() {
        class ObjectTest: MockUsable {
            static var anyValue: MockUsable { return ObjectTest() }

            func equal(to: MockUsable?) -> Bool {
                return true
            }
        }

        class ObjectUsage {
            func use(object: ObjectTest) {}
        }

        class ObjectUsageMock: ObjectUsage, MockDelegate {
            private var mock = Mock()
            var it: Mock { return mock }

            override func use(object: ObjectTest) {
                it.call(object)
            }
        }

        var objectTest: ObjectTest? = ObjectTest()
        weak var weakObjectTest = objectTest

        let mock = ObjectUsageMock()
        mock.it.expect().call(mock.use(object: Arg.eq(objectTest!)))

        objectTest = nil
        mock.it.resetStubs()
        mock.it.resetExpectations()

        XCTAssertNil(weakObjectTest)
    }

}
