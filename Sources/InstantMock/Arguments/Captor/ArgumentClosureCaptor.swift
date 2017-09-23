//
//  ArgumentClosureCaptor.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class enables to capture arguments of type closure */
public class ArgumentClosureCaptor<T> {

    /// Argument that captures values
    var arg: ArgumentCapture?

    /// Delegate for returning captured values
    fileprivate lazy var delegate: ArgumentCaptorValuesImpl<T> = {
        return ArgumentCaptorValuesImpl<T>(self.arg)
    }()

    /** Main initializer */
    public init() {}

}


/** Extension for returning captured valued */
extension ArgumentClosureCaptor: ArgumentCaptorValues {

    public var value: T? {
        return self.delegate.value
    }

    public var allValues: [T?] {
        return self.delegate.allValues
    }

}
