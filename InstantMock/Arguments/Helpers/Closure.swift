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

    /** Provide a default closure with provided signature */
    func cast<ARGS, RET>() -> (ARGS) -> RET {
        return Closure.cast()
    }

    /** Provide a default closure with provided signature */
    static func cast<ARGS, RET>() -> (ARGS) -> RET {
        let closure: (ARGS) -> RET = { args in return Void() as! RET }
        return closure
    }

}
