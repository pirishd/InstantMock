//
//  ArgumentClosureCaptor+OneArg.swift
//  InstantMock iOS
//
//  Created by Patrick on 22/07/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension that performs the actual capture for one arg */
extension ArgumentClosureCaptor {


    /** Capture an argument of expected type */
    public func capture<Arg1, Ret>() -> T where T == (Arg1) -> Ret {
        let factory = ArgumentFactoryImpl<T>()
        return self.capture(argFactory: factory, argStorage: ArgumentStorageImpl.instance) as (Arg1) -> Ret
    }


    /** Capture an argument of expected type (for dependency injection) */
    func capture<Arg1, Ret, F>(argFactory: F, argStorage: ArgumentStorage) -> (Arg1) -> Ret
        where F: ArgumentFactory, F.Value == T {

        // store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentCapture(typeDescription)
        self.arg = arg
        argStorage.store(arg)

        return DefaultClosureHandler.it() as (Arg1) -> Ret
    }

}
