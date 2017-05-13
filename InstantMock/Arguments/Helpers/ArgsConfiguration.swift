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

extension ArgsConfiguration {

    func numberOfArgValues() -> Int {
        return self.args.filter { $0 is ArgumentValue }.count
    }


    func numberOfArgVerify() -> Int {
        return self.args.filter { $0 is ArgumentVerify }.count
    }

}


extension ArgsConfiguration: Comparable {}


func ==(lhs: ArgsConfiguration, rhs: ArgsConfiguration) -> Bool {
    return lhs.numberOfArgValues() == rhs.numberOfArgValues() && lhs.numberOfArgVerify() == rhs.numberOfArgVerify()
}


func <(lhs: ArgsConfiguration, rhs: ArgsConfiguration) -> Bool {

    if lhs.numberOfArgValues() == rhs.numberOfArgValues() {
        return lhs.numberOfArgVerify() < rhs.numberOfArgVerify()
    }

    return lhs.numberOfArgValues() < rhs.numberOfArgValues()
}

