//
//  DefaultValueHandler.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class is a helper that provides default values */
class DefaultValueHandler<T> {


    /** Return the default value, or nil if type is neither `MockUsable`, nor `Closure` */
    var it: T? {
        var ret: T?

        // try to fetch the default value of `MockUsable` types
        if let mockUsableType = T.self as? MockUsable.Type {
            if let value = mockUsableType.anyValue as? T {
                ret = value
            }
        }

        return ret
    }

}
