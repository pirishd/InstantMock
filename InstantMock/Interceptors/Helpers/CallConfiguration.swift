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


    /** Initialize with function and args configuration */
    init(for function: String, with args: ArgsConfiguration) {
        self.function = function
        self.args = args
    }
    
}


extension CallConfiguration: Comparable {}


func ==(lhs: CallConfiguration, rhs: CallConfiguration) -> Bool {
    return lhs.args == rhs.args
}


func <(lhs: CallConfiguration, rhs: CallConfiguration) -> Bool {
    return lhs.args < rhs.args
}



