//
//  CallConfigurationTests.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class CallConfigurationTests: XCTestCase {


    func testEqual() {
        let args1 = ArgumentsConfiguration([ArgumentValueMock(12)])
        let args2 = ArgumentsConfiguration([ArgumentValueMock(13)])

        let configuration1 = CallConfiguration(for: "func", with: args1)
        let configuration2 = CallConfiguration(for: "func", with: args2)

        XCTAssertEqual(configuration1, configuration2)
    }


    func testGreaterThan() {
        let args1 = ArgumentsConfiguration([ArgumentValueMock(12), ArgumentValueMock(13)])
        let args2 = ArgumentsConfiguration([ArgumentValueMock(13), ArgumentAnyMock()])

        let configuration1 = CallConfiguration(for: "func", with: args1)
        let configuration2 = CallConfiguration(for: "func", with: args2)

        XCTAssertGreaterThan(configuration1, configuration2)
    }

}
