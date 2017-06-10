//
//  ArgumentClosureMock.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import InstantMock


class ArgumentClosureMock: ArgumentClosure {

    var description: String { return "argument_closure_mock" }

    func match(_ value: Any?) -> Bool {
        return true
    }

}
