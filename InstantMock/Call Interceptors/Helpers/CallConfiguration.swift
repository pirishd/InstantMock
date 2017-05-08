//
//  CallConfiguration.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Class representing the configuration of a call */
class CallConfiguration {

    /// Function called
    let function: String

    /// Arguments configuration
    let args: ArgsConfiguration

    init(for function: String, with args: ArgsConfiguration) {
        self.function = function
        self.args = args
    }

}
