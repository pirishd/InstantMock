//
//  ArgumentsConfiguration.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Class representing a configuration of arguments */
class ArgumentsConfiguration {

    /// Actual expected arguments
    let args: [Argument]


    /** Initialize with expected arguments */
    init(_ args: [Argument]) {
        self.args = args
    }

}


/** Extension that returns a description of a configuration */
extension ArgumentsConfiguration: CustomStringConvertible {

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

/** Extension that returns the number of args of any kinds */
extension ArgumentsConfiguration {

    /** Returns the number of arguments that must verify a certain value */
    func numberOfArgValues() -> Int {
        return self.args.filter { $0 is ArgumentValue }.count
    }

    /** Returns the number of arguments that must verify a certain condition */
    func numberOfArgVerify() -> Int {
        return self.args.filter { $0 is ArgumentVerify }.count
    }

}


/** Configurations are comparable depending on how the args must be verified */
extension ArgumentsConfiguration: Comparable {}

func ==(lhs: ArgumentsConfiguration, rhs: ArgumentsConfiguration) -> Bool {
    // configurations are equal if they have the same number of args that must verify a precise value or condition
    return lhs.numberOfArgValues() == rhs.numberOfArgValues() && lhs.numberOfArgVerify() == rhs.numberOfArgVerify()
}


func <(lhs: ArgumentsConfiguration, rhs: ArgumentsConfiguration) -> Bool {
    // when the number of args that must verify a certain value precisely is the same, look for conditions
    if lhs.numberOfArgValues() == rhs.numberOfArgValues() {
        return lhs.numberOfArgVerify() < rhs.numberOfArgVerify()
    }
    return lhs.numberOfArgValues() < rhs.numberOfArgValues()
}
