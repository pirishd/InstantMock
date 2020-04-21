//
//  Float+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `Float` easily usage in mocks */
extension Float: MockUsable {

    public static let any = 42.0 as Float

    public static var anyValue: MockUsable {
        return Float.any
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let doubleValue = value as? Float else { return false }
        return self == doubleValue
    }

}
