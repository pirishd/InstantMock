//
//  CallInterceptorRepositoryTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class CallInterceptorStorageTests: XCTestCase {

    private var repository: CallInterceptorStorage<Stub>!
    private var stub: Stub!


    override func setUp() {
        super.setUp()
        self.repository = CallInterceptorStorage<Stub>()
        self.stub = Stub()
    }


    func testInterceptors() {
        let interceptors = self.repository.interceptors(for: "")
        XCTAssertEqual(interceptors.count, 0)

        self.repository.store(interceptor: self.stub, for: "someFunction")
        XCTAssertEqual(interceptors.count, 0)
    }


    func testRegisterInterceptors() {
        self.repository.store(interceptor: self.stub, for: "someFunction")
        var interceptors = self.repository.interceptors(for: "someFunction")

        XCTAssertEqual(interceptors.count, 1)
        XCTAssertTrue(interceptors.first === self.stub)

        let stub2 = Stub()
        self.repository.store(interceptor: stub2, for: "someFunction")
        interceptors = self.repository.interceptors(for: "someFunction")

        XCTAssertEqual(interceptors.count, 2)
        XCTAssertTrue(interceptors.last === stub2)
    }


    func testAll() {
        self.repository.store(interceptor: self.stub, for: "someFunction")

        let stub2 = Stub()
        self.repository.store(interceptor: stub2, for: "someFunction")

        let stub3 = Stub()
        self.repository.store(interceptor: stub3, for: "someOtherFunction")

        let all = self.repository.all()
        XCTAssertEqual(all.count, 3)
        XCTAssertTrue(all.contains(where: { $0 === self.stub}))
        XCTAssertTrue(all.contains(where: { $0 === stub2}))
        XCTAssertTrue(all.contains(where: { $0 === stub3}))
    }


    func testRemoveAll() {
        self.repository.store(interceptor: stub, for: "someFunction")
        let stub2 = Stub()
        self.repository.store(interceptor: stub2, for: "someFunction")
        XCTAssertEqual(self.repository.all().count, 2)
        self.repository.removeAll()
        XCTAssertEqual(self.repository.all().count, 0)
    }

}
