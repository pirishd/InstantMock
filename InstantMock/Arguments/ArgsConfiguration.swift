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
    private let args: [Any?]

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
