//
//  CallInterceptor.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Base class for call interceptors */
public class CallInterceptor {

    /// list of argument configurations
    var argConfigurations = [ArgConfiguration]()


    /** Method is being called */
    @discardableResult
    func handleCall(_ args: [Any?]) -> Any? {
        fatalError("[CallInterceptor] handleCall: virtual method, must be overloaded in subclasses")
    }

}


/** Extension for a list of interceptors */
extension Collection where Iterator.Element: CallInterceptor {

    func matching<T: CallInterceptor>(_ args: [Any?]) -> [T] {
        return [T]()
    }

}
