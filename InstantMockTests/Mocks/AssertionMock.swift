//
//  AssertionMock.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import InstantMock


/** Mock for assertions, just register the passed parameters */
class AssertionMock: Assertion {

    var description: String?
    var file: StaticString?
    var line: UInt?

    func fail(_ description: String?, file: StaticString?, line: UInt?) {
        self.description = description
        self.file = file
        self.line = line
    }

}
