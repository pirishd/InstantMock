//
//  Int+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `Int` easily usage in mocks */
extension Int: MockUsable {

    public static let any = 42

    public static var anyValue: MockUsable {
        return Int.any
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let intValue = value as? Int else { return false }
        return self == intValue
    }

}
