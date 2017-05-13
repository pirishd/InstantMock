//
//  ArgumentFactoryMock.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import InstantMock


class ArgumentFactoryMock<T>: ArgumentFactory {

    func argument(value: T?) -> ArgumentValue {
        return ArgumentValueMock<T>(value)
    }

}
