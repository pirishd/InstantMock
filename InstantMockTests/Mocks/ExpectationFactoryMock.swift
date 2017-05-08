//
//  ExpectationFactoryMock.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import InstantMock


class ExpectationFactoryMock: ExpectationFactory {

    let assertionMock: AssertionMock

    init(withAssertionMock assertionMock: AssertionMock) {
        self.assertionMock = assertionMock
    }

    func expectation(withStub stub: Stub) -> Expectation {
        return Expectation(withStub: stub, assertion: assertionMock)
    }

}
