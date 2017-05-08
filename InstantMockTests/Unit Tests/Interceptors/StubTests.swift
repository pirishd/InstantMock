//
//  StubTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class StubTests: XCTestCase {

    private var stub: Stub!

    override func setUp() {
        super.setUp()
        self.stub = Stub()
    }

    func testHandleCall_nil() {
        let ret = self.stub.handleCall([])
        XCTAssertNil(ret)
    }


    func testHandleCall_andReturn() {
        self.stub.andReturn(36)
        let ret = self.stub.handleCall([])
        XCTAssertEqual(ret as! Int, 36)
    }


    func testHandleCall_andReturnClosure() {
        self.stub.andReturn(closure: { _ in return 12 })
        let ret = self.stub.handleCall([])
        XCTAssertEqual(ret as! Int, 12)
    }


    func testHandleCall_andReturn_andReturnClosure() {
        self.stub.andReturn(closure: { _ in return 12 }).andReturn(36)
        let ret = self.stub.handleCall([])
        XCTAssertEqual(ret as! Int, 36)
    }


    func testHandleCall_andDo() {

        var something = ""
        self.stub.andDo { _ in something = "not_empty" }

        _ = self.stub.handleCall([])
        XCTAssertEqual(something, "not_empty")
    }


    func testHandleCall_andReturn_andDo() {
        var something = ""
        self.stub.andDo({ _ in something = "not_empty" }).andReturn(36)

        let ret = self.stub.handleCall([])
        XCTAssertEqual(something, "not_empty")
        XCTAssertEqual(ret as! Int, 36)
    }


    func testHandleCall_andReturnClosure_andDo() {
        var something = ""
        self.stub.andDo({ _ in something = "not_empty" }).andReturn(closure: { _ in return 12 })

        let ret = self.stub.handleCall([])
        XCTAssertEqual(something, "not_empty")
        XCTAssertEqual(ret as! Int, 12)
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
        self.stub.andReturn(closure: { _ in return 12} )
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
        XCTAssertTrue(stub === best)
    }


    func testBest_several() {
        let stub1 = Stub()
        stub1.configuration = CallConfiguration(for: "func", with: ArgsConfiguration(with: [12, 37, 42]))

        let stub2 = Stub()
        stub2.configuration = CallConfiguration(for: "func", with: ArgsConfiguration(with: [Int.any, 37, 42]))

        var list = [Stub]()
        list.append(stub1)
        list.append(stub2)

        let best = list.best()
        XCTAssertTrue(stub1 === best)
    }

}

