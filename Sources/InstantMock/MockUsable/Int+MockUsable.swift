//
//  Int+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

/** Extension for making `Int` easily usage in mocks */
extension FixedWidthInteger where Self: MockUsable {

    public func equal(to value: MockUsable?) -> Bool {
        guard let intValue = value as? Self else { return false }
        return self == intValue
    }

}

extension Int: MockUsable {
    public static let any = 42

    public static var anyValue: MockUsable {
        return Int.any
    }
}
extension Int64: MockUsable {
    public static let any = 42 as Int64

    public static var anyValue: MockUsable {
        return Int64.any
    }
}
extension UInt: MockUsable {
    public static let any = 42 as UInt

    public static var anyValue: MockUsable {
        return UInt.any
    }
}
extension UInt64: MockUsable {
    public static let any = 42 as UInt64

    public static var anyValue: MockUsable {
        return UInt64.any
    }
}
