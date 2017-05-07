//
//  CallInterceptorRepositoryTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class CallInterceptorStorageTests: XCTestCase {

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


}
