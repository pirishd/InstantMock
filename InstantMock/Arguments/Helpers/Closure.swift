//
//  Closure.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/**
    Helper that provides a simple way to create closure arguments
    with any argument and return value types
 */
class Closure {

    required init() {}

    /** Provide a dummy closure with provided signature */
    func withSignature<ARGS, RET>() -> ((ARGS) -> RET) {
        let closure: (ARGS) -> RET = { args in return Void() as! RET }
        return closure
    }

}
