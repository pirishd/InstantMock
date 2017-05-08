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

