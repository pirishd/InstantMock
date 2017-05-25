//
//  MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Protocol available for making a type easily mockable */
public protocol MockUsable {

    /// Represent any value for the type
    static var anyValue: MockUsable { get }

    /// Return true if self equals to provided value
    func equal(to: MockUsable?) -> Bool

}
