//
//  Arg.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class represents a generic Argument being registered */
class Arg<T> {


    /** Register a value */
    static func eq(_ val: T) -> T {
        let arg = ArgValue<T>(val)
        ArgStorage.instance.store(arg)
        return val
    }


    /** Register a closure to be verified */
    static func verify(_ closure: @escaping (T) -> Bool) -> T {

        // store instance
        let arg = ArgVerify<T>(closure)
        ArgStorage.instance.store(arg)

        // return default value
        guard let ret = DefaultValueHandler<T>().it else {
            fatalError("Unexpected type, only `MockUsable` types can be used with `verify`")
        }
        return ret
    }


    /** Register Any value */
    static var any: T {

        // store instance
        let arg = ArgAny("\(T.self)")
        ArgStorage.instance.store(arg)

        // return default value
        guard let ret = DefaultValueHandler<T>().it else {
            fatalError("Unexpected type, only `MockUsable` types can be used with `any`")
        }
        return ret
    }

}
