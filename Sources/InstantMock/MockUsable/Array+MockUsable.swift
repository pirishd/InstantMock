//
//  Array+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `Array` easily usage in mocks */
extension Array: MockUsable {

    public static var any: Array {
        return Array()
    }

    public static var anyValue: MockUsable {
        return Array.any
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let arrayValue = value as? Array else { return false }
        return VerifierImpl.instance.equalArray(self, to: arrayValue)
    }

}
