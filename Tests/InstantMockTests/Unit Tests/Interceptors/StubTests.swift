//
//  StubTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class StubTests: XCTestCase {

    private var stub: Stub!
    private var argsConfig: ArgumentsConfiguration!


    override func setUp() {
        super.setUp()
        self.stub = Stub()
        self.argsConfig = ArgumentsConfiguration([Argument]())
    }


    func testHandleCall_nil() {
        let ret = try! self.stub.handleCall([])
        XCTAssertNil(ret)
    }


    func testHandleCall_andReturn() {
        self.stub.andReturn(36)
        let ret = try! self.stub.handleCall([])
        XCTAssertEqual(ret as! Int, 36)
    }


    func testReturns_andThrow() {
        enum SomeError: Error {
            case some
        }
        self.stub.andThrow(SomeError.some)

        XCTAssertThrowsError(try self.stub.handleCall([])) { (error) -> Void in
            XCTAssertEqual(error as? SomeError, SomeError.some)
        }
    }


    func testHandleCall_andReturnClosure() {
        self.stub.andReturn(closure: { _ in return 12 })
        let ret = try! self.stub.handleCall([])
        XCTAssertEqual(ret as! Int, 12)
    }


    func testHandleCall_andReturn_andReturnClosure() {
        self.stub.andReturn(closure: { _ in return 12 }).andReturn(36)
        let ret = try! self.stub.handleCall([])
        XCTAssertEqual(ret as! Int, 36)
    }


    func testHandleCall_andDo() {
        var something = ""
        self.stub.andDo { _ in something = "not_empty" }

        _ = try! self.stub.handleCall([])
        XCTAssertEqual(something, "not_empty")
    }


    func testHandleCall_andReturn_andDo() {
        var something = ""
        self.stub.andDo({ _ in something = "not_empty" }).andReturn(36)

        let ret = try! self.stub.handleCall([])
        XCTAssertEqual(something, "not_empty")
        XCTAssertEqual(ret as! Int, 36)
    }


    func testHandleCall_andReturnClosure_andDo() {
        var something = ""
        self.stub.andDo({ _ in something = "not_empty" }).andReturn(closure: { _ in return 12 })

        let ret = try! self.stub.handleCall([])
        XCTAssertEqual(something, "not_empty")
        XCTAssertEqual(ret as! Int, 12)
    }


    func testHandleCall_capture() {
        let captureMock = ArgumentCaptureMock()
        let argsConfig = ArgumentsConfiguration([captureMock])
        self.stub.configuration = CallConfiguration(for: "func", with: argsConfig)

        _ = try! self.stub.handleCall(["Hello"])
        XCTAssertEqual(captureMock.value as! String, "Hello")
    }


    func testReturns_false() {
        let returns = self.stub.returns
        XCTAssertFalse(returns)
    }


    func testReturns_andReturn() {
        self.stub.andReturn(12)
        let returns = self.stub.returns
        XCTAssertTrue(returns)
    }


    func testReturns_andReturnClosure() {
        self.stub.andReturn(closure: { _ in return 12})
        let returns = self.stub.returns
        XCTAssertTrue(returns)
    }


    func testBest_none() {
        let list = [Stub]()
        let best = list.best()
        XCTAssertNil(best)
    }


    func testBest_one() {
        let stub = Stub()

        var list = [Stub]()
        list.append(stub)

        let best = list.best()
        XCTAssertTrue(best === stub)
    }


    func testBest_several() {
        let valueMock12 = ArgumentValueMock(12)
        let valueMock37 = ArgumentValueMock(37)
        let valueMock42 = ArgumentValueMock(42)

        let stub1 = Stub()
        stub1.configuration = CallConfiguration(for: "func", with: ArgumentsConfiguration([ArgumentAnyMock(), valueMock37, valueMock42]))

        let stub2 = Stub()
        stub2.configuration = CallConfiguration(for: "func", with: ArgumentsConfiguration([valueMock12, valueMock37, valueMock42]))

        var list = [Stub]()
        list.append(stub1)
        list.append(stub2)

        let best = list.best()
        XCTAssertTrue(best === stub2)
    }


    func testEqual() {
        let stub1 = Stub()
        stub1.configuration = CallConfiguration(for: "func", with: ArgumentsConfiguration([ArgumentValueMock(12)]))
        let stub2 = Stub()
        stub2.configuration = CallConfiguration(for: "func", with: ArgumentsConfiguration([ArgumentValueMock(13)]))

        XCTAssertEqual(stub1, stub2)
    }


    func testEqual_defaultFailure() {
        let stub1 = Stub()
        let stub2 = Stub()
        XCTAssertNotEqual(stub1, stub2)
    }


    func testGreaterThan() {
        let stub1 = Stub()
        stub1.configuration = CallConfiguration(for: "func", with: ArgumentsConfiguration([ArgumentValueMock(12), ArgumentValueMock(13)]))
        let stub2 = Stub()
        stub2.configuration = CallConfiguration(for: "func", with: ArgumentsConfiguration([ArgumentValueMock(12), ArgumentAnyMock()]))

        XCTAssertGreaterThan(stub1, stub2)
    }


    func testGreaterThan_defaultFailure() {
        let stub1 = Stub()
        let stub2 = Stub()
        XCTAssertFalse(stub1 > stub2)
    }

}
