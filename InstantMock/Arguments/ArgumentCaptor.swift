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
        let factory = ArgumentFactoryImpl<T>()
        return self.capture(argFactory: factory)
    }


    /** Capture an argument of expected type with factory (dependency injection) */
    func capture<F>(argFactory: F) ->T where F: ArgumentFactory, F.Value == T {

        // store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentCapture(typeDescription)
        ArgumentStorageImpl.instance.store(arg)

        // return default value
        guard let ret = DefaultValueHandler<T>().it else {
            fatalError("Unexpected type, only `MockUsable` types can be used with `captors`")
        }
        return ret

    }

}
