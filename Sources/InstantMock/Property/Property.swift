//
//  Property.swift
//  InstantMock iOS
//
//  Created by Patrick on 03/03/2018.
//  Copyright © 2018 pirishd. All rights reserved.
//


/** Represents a property to be mocked */
public class Property {

    /// mock dependency
    private weak var mock: Mock?


    /// Initializers
    init(mock: Mock) {
        self.mock = mock
    }


    /** Register a mocked setter */
    public func set<T>(_ prop: T, value: T) {
        if let function = self.mock?.deferredFunction {
            self.mock?.handleRegistration(of: function, with: [value]) as Void?
        }
    }

}
