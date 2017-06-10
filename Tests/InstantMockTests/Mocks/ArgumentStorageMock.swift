//
//  ArgumentStorageMock.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import InstantMock


class ArgumentStorageMock: ArgumentStorage {

    func store(_ arg: Argument) {
        args.append(arg)
    }

    var args = [Argument]()
    func all() -> [Argument] {
        return args
    }

    func flush() {
        args.removeAll()
    }

}
