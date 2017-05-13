//
//  ArgumentValueMock.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import InstantMock


class ArgumentValueMock<T>: ArgumentValueTyped {

    var value: T?
    required init(_ value: T?) {
        self.value = value
    }

    var description: String { return "argument_value_mock" }

    func match(_ value: Any?) -> Bool {
        return true
    }
}
