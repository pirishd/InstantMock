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
public class Closure {


    /** Provide a dummy closure */
    static func any<ARGS, RET>() -> ((ARGS) -> RET) {
        let closure: (ARGS) -> RET = { args in return Void() as! RET }
        return closure
    }

}
