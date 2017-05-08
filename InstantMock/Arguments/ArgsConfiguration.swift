//
//  ArgsConfiguration.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Class representing a configuration of arguments */
class ArgsConfiguration {


    /// Actual expected arguments
    fileprivate let args: [Any?]


    /// Configuration of the arguments
    lazy var values: [ArgConfiguration] = {
        return self.toConfig()
    }()


    /** Initialize with expected arguments */
    init(with args: [Any?]) {
        self.args = args
    }


    /** Create list of argument configurations from registered arguments */
    private func toConfig() -> [ArgConfiguration] {
        return self.args.map { arg in
            var isAny = false
            if let usable = arg as? MockUsable {
                isAny = usable.equal(to: type(of: usable).anyValue)
            }
            return ArgConfiguration(value: arg, isAny: isAny)
        }
    }

}


/** Extension that returns a description of a configuration */
extension ArgsConfiguration: CustomStringConvertible {

    var description: String {
        var value = ""

        if self.args.count > 0 {
            let valuesDescriptions = self.values.map { $0.description }
            value = valuesDescriptions.joined(separator: ", ")
        } else {
            value = "none"
        }

        return value
    }

}
