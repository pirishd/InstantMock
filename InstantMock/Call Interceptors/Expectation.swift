//
//  Expectation.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


public class Expectation: CallInterceptor {

    private let stub: Stub

    init(withStub stub: Stub) {
        self.stub = stub
    }

}
