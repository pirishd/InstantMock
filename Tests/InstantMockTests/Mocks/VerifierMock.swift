//
//  VerifierMock.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import InstantMock


/** Mock for Verifier */
class VerifierMock: Verifier {

    var arg: Any?
    var value: Any?

    var called = false

    func equal(_ arg: Any?, to value: Any?) -> Bool {
        self.arg = arg
        self.value = value
        self.called = true
        return false
    }

}
