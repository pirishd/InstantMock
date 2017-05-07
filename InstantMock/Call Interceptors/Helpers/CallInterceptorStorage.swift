//
//  CallInterceptorStorage.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Class responsible for storing call interceptors */
class CallInterceptorStorage<T: CallInterceptor> {


    /** Storing dictionary */
    private var repository = [String: [T]]()


    /**
        Register an interceptor
        - parameter interceptor: call interceptor to register
        - parameter function: function name triggering this interceptor
        - parameter args: list of arguments passed to the function for this interceptor
     */
    func store(interceptor: T, for function: String) {
        var interceptors = self.repository[function] ?? [T]()
        interceptors.append(interceptor)
        self.repository[function] = interceptors
    }


    /**
        Return the list of interceptors for the given function
        - parameter function: function name for retrieving interceptors
        - returns: list of interceptors
     */
    func interceptors(for function: String) -> [T] {
        return self.repository[function] ?? [T]()
    }


    /** Return the list of all the interceptors */
    func all() -> [T] {
        return self.repository.values.flatMap { (values: [T]) -> [T] in
            return values
        }
    }

}
