//
//  ArgumentCaptor.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class enables to capture arguments of any types */
class ArgumentCaptor<T> {


    /** Capture an argument of expected type */
    func capture() -> T {

        // store instance
        let arg = ArgumentCaptureImpl<T>("\(T.self)")
        ArgStorage.instance.store(arg)

        // return default value
        guard let ret = DefaultValueHandler<T>().it else {
            fatalError("Unexpected type, only `MockUsable` types can be used with `captors`")
        }
        return ret
    }

}
