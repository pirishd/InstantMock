//
//  ArgumentFactoryMock.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import InstantMock


class ArgumentFactoryMock<T>: ArgumentFactory {

    var argumentValue: ArgumentValue?
    var argumentAny: ArgumentAny?
    var argumentVerify: ArgumentVerify?
    var argumentCapture: ArgumentCapture?


    func argument(value: T?) -> ArgumentValue {
        let argValue = ArgumentValueMock<T>(value)
        self.argumentValue = argValue
        return argValue
    }


    func argumentAny(_ typeDescription: String) -> ArgumentAny {
        let argAny = ArgumentAnyMock()
        self.argumentAny = argAny
        return argAny
    }


    func argument(condition: @escaping (T) -> Bool) -> ArgumentVerify {
        let argVerify = ArgumentVerifyMock<T>(condition)
        self.argumentVerify = argVerify
        return argVerify
    }


    func argumentCapture(_ typeDescription: String) -> ArgumentCapture {
        let argCapture = ArgumentCaptureMock()
        self.argumentCapture = argCapture
        return argCapture
    }

}
