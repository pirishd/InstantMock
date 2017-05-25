//
//  ArgumentCaptorValues.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Protocol for returning captured values */
protocol ArgumentCaptorValues {
    associatedtype Value
    var value: Value? { get }
    var allValues: [Value?] { get }
}


/** Main implementation for returning captured values */
public class ArgumentCaptorValuesImpl<T>: ArgumentCaptorValues {

    /// Argument capture instance
    fileprivate var arg: ArgumentCapture?

    /// Captured value
    public var value: T? {
        var ret: T?
        if let captureArg = self.arg {
            ret = captureArg.value as? T
        }
        return ret
    }

    /// All captured values
    public var allValues: [T?] {
        var ret = [T?]()
        if let captureArg = self.arg {
            ret = captureArg.allValues.map { $0 as? T }.flatMap { $0 }
        }
        return ret
    }


    /** Initializer */
    init(_ arg: ArgumentCapture?) {
        self.arg = arg
    }

}

