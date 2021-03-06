//
//  ArgumentClosureCaptor+TwoArgs.swift
//  InstantMock iOS
//
//  Created by Patrick on 22/07/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension that performs the actual capture for two args */
extension ArgumentClosureCaptor {


    /** Capture an closure of expected type */
    public func capture<Arg1, Arg2, Ret>() -> T where T == (Arg1, Arg2) -> Ret {
        let factory = ArgumentFactoryImpl<T>()
        return self.capture(argFactory: factory, argStorage: ArgumentStorageImpl.instance) as (Arg1, Arg2) -> Ret
    }


    /** Capture a closure of expected type that can throw */
    public func capture<Arg1, Arg2, Ret>() -> T where T == (Arg1, Arg2) throws -> Ret {
        let factory = ArgumentFactoryImpl<T>()
        return self.capture(argFactory: factory, argStorage: ArgumentStorageImpl.instance) as (Arg1, Arg2) throws -> Ret
    }


    /** Capture an argument of expected type (for dependency injection) */
    func capture<Arg1, Arg2, Ret, F>(argFactory: F, argStorage: ArgumentStorage) -> (Arg1, Arg2) -> Ret
        where F: ArgumentFactory, F.Value == T {

        // store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentCapture(typeDescription)
        self.arg = arg
        argStorage.store(arg)

        return DefaultClosureHandler.it() as (Arg1, Arg2) -> Ret
    }

}

