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
    var argsConfiguration: ArgsConfiguration?


    /** Method is being called */
    @discardableResult
    func handleCall(_ args: [Any?]) -> Any? {
        fatalError("[CallInterceptor] handleCall: virtual method, must be overloaded in subclasses")
    }

}


/** Extension for a list of interceptors */
extension Collection where Iterator.Element: CallInterceptor {

    /** Filter a list of interceptors if they match the provided arguments */
    func matching(_ args: [Any?]) -> [CallInterceptor] {

        // create arg matcher
        let argsMatcher = ArgsMatcher(args)

        // return filtered list
        return self.filter { interceptor in
            var matching = false
            if let config = interceptor.argsConfiguration {
                matching = argsMatcher.match(config)
            }
            return matching
        }

    }

}
