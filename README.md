# InstantMock
## Create mocks easily in Swift 3

## Introduction
*InstantMock* aims at creating mocks easily in Swift 3. It provides a simple way to mock, stub and verify expectations.
This project is in beta for now. Suggestions and issue reports are welcome.

## Usage

*InstantMock* works in two parts:
* **Mock creation**: this part aims at creating mocks implementing a protocol, or using inheritance.
* **Settings expectations and stubs**: this part is where mocks are used in your actual tests.

### Mocking

### Using delegation
Mocks can be created by just implementing the protocol `MockDelegate`. It aims at providing a delegate instance that actually does all the work of registering and handling calls.

The example below assumes we want to mock this protocol:
```
protocol Foo {
    func bar(arg1: String, arg2: Int) -> Bool
}
```

In your test project, create a new class `FooMock` that adopts the `Foo` and `MockDelegate` protocols. In the `Foo` implementation, just call the `call` function on the delegate instance and provides the arguments received. 

```
class FooMock: MockDelegate {

    // create delegate instance
    private let delegate = Mock()
    
    // only getter to be implemented
    var it: Mock {
        return delegate
    }
}

// Extension for the `Foo` protocol
extension FooMock: Foo {

    // implement `bar` function, by calling `call` to the delegate
    // and provides the args
    func bar(arg1: String, arg2: Int) -> Bool {
        return delegate.call(arg1, arg2)!
    }
    
}
```

#### Using inheritance

When possible, mocks can also be created by inheriting the `Mock` class.

The example below uses the same `Foo` protocol as above. In your test project, create a new class `FooMock` that adopts the `Foo` protocol, and inherits from `Mock`:

```
class FooMock: Mock, Foo {

    // implement `bar` function, by calling `call` to `super`
    // and provides the args
    func bar(arg1: String, arg2: Int) -> Bool {
        return super.call(arg1, arg2)!
    }
    
}
```

#### Pre-requisites

Using `call` on `Mock` instances requires to follow certain rules for handling non-optional return values:
* use `!` after the call
* make sure the return type follows the `MockUsable` protocol (see [below](FIXME)).

### Expectations

Expectations are set using the syntax like the following example:
```
// create mock
let mock = FooMock()

// set expectation
mock.expect().call(mock.bar(arg1: Arg.eq("hello"), arg2: Arg.eq(42)))
```
Here we expect `bar` to be called on `mock` with "hello" and 42 as arguments.

In addition, expectations can be set on the number of calls:
```
// set expectation, must be called twice
mock.expect().call(mock.bar(arg1: Arg.eq("hello"), arg2: Arg.eq(42)), numberOfTimes: 2)
```

Verifying expectations is done this way:
```
mock.verify()
```

### Stubs

### Argument Matching

### Argument Capturing

### MockUsable

## Changelog
List of changes can be found [here](CHANGELOG.md).

## Requirements
Todo

## Installation
Todo

## Inspiration
Todo

## Author
Todo

## License
Todo
