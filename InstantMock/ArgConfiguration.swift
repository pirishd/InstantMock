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


/** Extension for a list of arguments */
extension Collection {

    /** Create list of argument configuration from registered arguments */
    func toArgConfigurations() -> [ArgConfiguration] {
        return self.map { arg in
            var isAny = false
            if let usable = arg as? MockUsable {
                isAny = usable.equal(to: usable.anyValue)
            }
            return ArgConfiguration(value: arg, isAny: isAny)
        }
    }

}
