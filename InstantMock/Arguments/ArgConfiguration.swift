//
//  ArgConfiguration.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Class representing the configuration of an argument */
class ArgConfiguration {

    /// Expected value for the argument
    let value: Any?

    /// Expected value should match anything
    let isAny: Bool

    /** Create a new argument configuration */
    init(value: Any?, isAny: Bool) {
        self.value = value
        self.isAny = isAny
    }

}
