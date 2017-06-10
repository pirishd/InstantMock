//
//  ArgumentCaptureMock.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import InstantMock


class ArgumentCaptureMock: ArgumentCapture {

    var description: String { return "argument_capture_mock" }

    func match(_ value: Any?) -> Bool {
        return true
    }

    var value: Any?
    func setValue(_ value: Any?) {
        self.value = value
    }

    var allValues: [Any?] {
        return [value]
    }

}
