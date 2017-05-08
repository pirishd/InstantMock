//
//  Set+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `Set` easily usage in mocks */
extension Set: MockUsable {

    public static var any: Set {
        return Set()
    }

    public static var anyValue: MockUsable {
        return Set.any
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let setValue = value as? Set else { return false }
        return self == setValue
    }

}
