//
//  Stub.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class represents a stub */
public class Stub: CallInterceptor {

}



// MARK: Registration
extension Stub {

    /** register call */
    @discardableResult
    public func call<T: Any>(_ value: T) -> Stub {
        // nothing to do
        return self
    }

}
