//
//  MockStubProtocolTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class DummyStubClass: MockDelegate, MockStub {

    private let mock = Mock()

    var it: Mock {
        return self.mock
    }

    @discardableResult
    func stub() -> Stub {
        return it.stub()
    }

}


class MockStubProtocolTests: XCTestCase {


    func testStub() {
        let dummy = DummyStubClass()
        dummy.stub()
    }

}
