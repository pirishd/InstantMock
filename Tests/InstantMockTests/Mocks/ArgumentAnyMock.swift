//
//  ArgumentAnyMock.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import InstantMock


class ArgumentAnyMock: ArgumentAny {

    var description: String { return "argument_any_mock" }

    func match(_ value: Any?) -> Bool {
        return true
    }

}
