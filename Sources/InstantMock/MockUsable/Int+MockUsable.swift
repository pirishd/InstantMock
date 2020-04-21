//
//  Int+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `Int` easily usage in mocks */
extension FixedWidthInteger where Self: MockUsable {

    public static var anyValue: MockUsable {
        return Int.any
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let intValue = value as? Self else { return false }
        return self == intValue
    }

}

extension Int: MockUsable { public static let any = 42 }
extension Int64: MockUsable { public static let any = 42 }
extension UInt: MockUsable { public static let any = 42 }
extension UInt64: MockUsable { public static let any = 42 }
