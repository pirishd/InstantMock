//
//  ArgsConfiguration.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Class representing a configuration of arguments */
class ArgsConfiguration {

    /// Actual expected arguments
    let args: [Argument]


    /** Initialize with expected arguments */
    init(_ args: [Argument]) {
        self.args = args
    }

}


/** Extension that returns a description of a configuration */
extension ArgsConfiguration: CustomStringConvertible {

    var description: String {
        var value = ""

        if self.args.count > 0 {
            let valuesDescriptions = self.args.map { $0.description }
            value = valuesDescriptions.joined(separator: ", ")
        } else {
            value = "none"
        }
        
        return value
    }
    
}
