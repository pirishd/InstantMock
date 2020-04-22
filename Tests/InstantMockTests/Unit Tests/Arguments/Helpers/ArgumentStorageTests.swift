//
//  ArgumentStorageTests.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class ArgumentStorageTests: XCTestCase {

    private var storage: ArgumentStorageImpl!

    override func setUp() {
        super.setUp()
        self.storage = ArgumentStorageImpl()
    }


    func testStore() {
        var count = self.storage.all().count
        XCTAssertEqual(count, 0)

        let arg1 = ArgumentValueMock("Hello")
        self.storage.store(arg1)

        count = self.storage.all().count
        XCTAssertEqual(count, 1)

        let arg2 = ArgumentValueMock("Hello2")
        self.storage.store(arg2)
        count = self.storage.all().count
        XCTAssertEqual(count, 2)
    }


    func testFlush() {
        self.storage.flush()
        var count = self.storage.all().count
        XCTAssertEqual(count, 0)

        let arg1 = ArgumentValueMock("Hello")
        self.storage.store(arg1)

        self.storage.flush()

        count = self.storage.all().count
        XCTAssertEqual(count, 0)
    }

}
