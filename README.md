<p align="center">
    <img src="https://raw.githubusercontent.com/pirishd/InstantMock/master/doc/images/logo.png" width="212" />
</p>

# InstantMock

## Create Mocks Easily in Swift 4

[![Build Status](https://api.travis-ci.org/pirishd/InstantMock.svg)](https://travis-ci.org/pirishd/InstantMock/) [![codecov.io](https://codecov.io/gh/pirishd/InstantMock/branch/master/graphs/badge.svg)](https://codecov.io/gh/pirishd/InstantMock/branch/master)

*InstantMock* aims at creating mocks easily in Swift 4, and configuring them with expectations or stubbed implementations.

For examples, see `Example.playground`.

Swift versions compatibility:

Swift version | InstantMock version
---|---
4.2 | 2.2.X
4.0 | 2.0/2.1
3.X | 1.1.X

## How to Create a Mock?

*InstantMock* enables to create a single mock that can be used in many tests, for a protocol or a class.

### For a Protocol

The easiest way to create a mock for a protocol is to inherit from the `Mock` class.
```Swift
// MARK: Protocol to be mocked
protocol Foo {
    func bar(arg1: String, arg2: Int) -> Bool
}

// MARK: Mock class inherits from `Mock` and adopts the `Foo` protocol
class FooMock: Mock, Foo {

    // implement `bar` of the `Foo` protocol
    func bar(arg1: String, arg2: Int) -> Bool {
        return super.call(arg1, arg2)! // provide values to parent class
    }

}
```

### For a Class

To create a mock for a class, the mock must adopt the `MockDelegate` protocol.
```Swift
// MARK: Class to be mocked
class Foo {
    func bar(arg1: String, arg2: Int) -> Bool
}

// MARK: Mock class inherits from `Foo` and adopts the `MockDelegate` protocol
class FooMock: Foo, MockDelegate {

    // create `Mock` delegate instance
    private let mock = Mock()

    // conform to the `MockDelegate` protocol, by providing the `Mock` instance
    var it: Mock {
        return mock
    }

    // implement `bar` of the `Foo` class
    override func bar(arg1: String, arg2: Int) -> Bool {
        return mock.call(arg1, arg2)! // provide values to the delegate
    }

}
```

### Rules

To work properly, mocks must comply with a few rules regarding return values, due to Swift strong typing.

#### Optional Return Value
The syntax is as follow:
```Swift
func returnsOptional() -> Bool? {
    return mock.call()
}
```
Here, `call()` returns `nil` or `Void`.

#### Non-Optional Return Value

For some methods, mocks must return non-optional values. If a return value type adopts the [MockUsable](#mockusable) protocol (which is the case for the most common types like `Bool`, `Int`…), just force unwrapping the result to `call()`, like in the following example:
```Swift
func returnsMockUsable() -> Bool { // `Bool` adopts `MockUsable`
    return mock.call()! // force unwrapping
}
```
For other types, make sure to provide a default value, like in the following example:
```Swift
func returnsCustom() -> CustomType {
    return mock.call() ?? CustomType() // return a `CustomType` default value
}
```
#### Throwing
For catching errors on throwing methods, simply use `callThrowing()` instead of `call()`.

If a return value type adopts the [MockUsable](#mockusable) protocol (which is the case for the most common types like `Bool`, `Int`…), just force unwrapping the result to `callThrowing()`, like in the following example:
```Swift
func bazMockUsable() throws -> Bool {
    return try callThrowing()!
}
```
For other types, make sure to provide a default value, like in the following example:
```Swift
func bazCustom() throws -> CustomType {
    return try callThrowing() ?? CustomType() // return a `CustomType` default value
}
```

#### Properties
It is possible to mock properties declared in a protocol, like in the following example:
```Swift
// define protocol with a property `prop` that has a getter and a setter
protocol FooProperty {
    var prop: String { get set }
}

// mock of `FooProperty`
class FooPropertyMock: Mock, FooProperty {
    var prop: String {
        get { return super.call()! }
        set { return super.call(newValue) }
    }
}
```


## How to Set Expectations?

Expectations aim at verifying that a call is done with some arguments. They are set using a syntax like in the following example:
```Swift
// create mock instance
let mock = FooMock()

// create expectation on `mock`, that is verified when `bar` is called
// with "hello" for `arg1` and any value of the type of `arg2`
mock.expect().call(
    mock.bar(arg1: Arg.eq("hello"), arg2: Arg.any())
)
```

### Reject
Rejections are the contrary of expectations. They make sure no call is being done with some arguments. Simply use `reject()` instead of `expect()`.

### Number of calls
In addition, expectations and rejections can be set on the number of calls:
Use the following syntax:
```Swift
// create expectation on `mock`, that is verified when 2 calls are done on `bar`
// with "hello" for `arg1` and any value of the type of `arg2`
mock.expect().call(
    mock.bar(arg1: Arg.eq("hello"), arg2: Arg.any()),
    count: 2
)
```

### Properties
Setting expectations on properties can be done using the following syntax:

```Swift
// create mock instance
let mock = FooPropertyMock()

// create expectation on `mock`, that is verified when the property `prop` is called
mock.expect().call(mock.prop)

// create expectation on `mock`, that is verified when the property `prop` is set
// with the exact value "hello"
mock.expect().call(
    mock.property.set(mock.prop, value: Arg.eq("hello"))
)
```

### Verifications
Verifying expectations and rejections is done this way:
```Swift
// test fails when any of the expectations or rejections set on `mock` is not verified
mock.verify()
```

### Reset Expectations
Expecations can be reset this way:
```Swift
mock.resetExpectations()
```

## How to Stub Calls?

Stubs aim at performing actions when a function is called with some arguments. They are set using a syntax like in the following example:

```Swift
// create mock instance
let mock = FooMock()

// create stubbed implementation of the `bar` method, which returns `true` when called
// with "hello" for `arg1` and any value of the type of `arg2`
mock.stub().call(
    mock.bar(arg1: Arg.eq("hello"), arg2: Arg.any())
).andReturn(true)
````

### Return Value
Set the return value with `andReturn(…)` on the stub instance.

### Compute a Return Value
This is done with `andReturn(closure: { _ in return … })` on the stub instance. This enables to return different values on the same stub, depending on some conditions.

### Call Another Function
This is done with `andDo( { _ in … } )` on the stub instance.

### Throw an Error
This is done with `andThrow(…)` on the stub instance.

### Chaining
Chaining several actions on the same stub is possible, given they don't confict. For example, it is possible to return a value and call another function, like in `andReturn(true).andDo({ _ in print("something") })`.

Rules:
* the last closure registered by `andDo` is called first
* the last error registered by `andThrow` is thrown
* the last return value registered by `andReturn` is returned
* otherwise, the last return value computation method, registered by `andReturn(closure:)`, is called

### Reset Stubs
Stubs can be reset this way:
```Swift
mock.resetStubs()
```

Example:
```Swift
// configure mock to return "string" when calling `basic` whatever provided arguments
mock.stub().call(mock.basic(arg1: Arg.any(), arg2: Arg.any())).andReturn("string")

// reset the previously configured stubs
mock.resetStubs()

// calling `basic` does not return "string"
let ret = mock.basic(arg1: "", arg2: 2)
XCTAssertNotEqual(ret, "string")
```

## Argument Matching

Expectations are verified only if arguments match what is registered. Same goes for calling stubbed implementations.

### Exact Value
Matching an exact value is done with `Arg.eq(…)`.

### Any Value
Matching any value can be done for types that adopt the `MockUsable` protocol, with `Arg.any()`.

### Certain Condition
Matching a value that verifies a certain condition is done with `Arg.verify({ _  in return … })`.

### Closure
Matching a closure is a special case. Use the following syntax: `Arg.closure()`.

*Limitation: closures can be matched as long as they have less than 5 arguments.*

## Argument Capturing

Arguments can also be captured for later use thanks to the `ArgumentCaptor` class.

For example:
```Swift
// create captor for type `String`
let captor = ArgumentCaptor<String>()

// create expectation on `mock`, that is verified when `bar` is called
// with 42 for `arg2`. All values for `arg1` are captured.
mock.expect().call(mock.bar(arg1: captor.capture(), arg2: Arg.eq(42)))
...

// retrieve the last captured value
let value = captor.value

// retrieve all captured values
let values = captor.allValues
```
### Capturing a Closure

Capturing a closure is a special case. Use the following syntax:

*Limitation: closures can be captured as long as they have less than 5 arguments.*

```Swift
// create captor for type closure `(Int) -> Bool`
let captor = ArgumentClosureCaptor<(Int) -> Bool>()
...
// retrieve the last captured closure, and call it
let ret = captor.value!(42)
```

## MockUsable
`MockUsable` is a protocol that makes types easily usable in mocks.
For a given type, it allows to return non-optional values and to match any values.

Adding `MockUsable` on an existing type is done by creating an extension that adopts the protocol. For example:


```Swift
extension SomeClass: MockUsable {

    static var any = SomeClass() // any value

    // return any value
    public static var anyValue: MockUsable {
        return SomeClass.any
    }

    // returns true if an object is equal to another `MockUsable` object
    public func equal(to value: MockUsable?) -> Bool {
        guard let value = value as? SomeClass else { return false }
        return self == value
    }

}
```

Adding `MockUsable` on an existing type that uses inheritance, should always be done on the deepest subclass.
Indeed, adding this extension to both a parent and a subclass would create build conflicts.

### Supported Types

For now, the following types are `MockUsable`:
* Bool
* Int
* Double
* String
* Set
* Array
* Dictionary

## Changelog
List of changes can be found [here](CHANGELOG.md).

## Requirements
* Xcode 10
* iOS 9
* osX 10.10

## Installation
### Cocoapods
*InstantMock* is available using [CocoaPods](http://cocoapods.org). Just add the following line to your `Podfile`:
```
pod 'InstantMock'
```

### Swift Package Manager
*InstantMock* is available using Swift Package Manager. Just add the following line to your `Package.swift` file:
```Swift
let package = Package(
    name: "example",
    dependencies: [
        .Package(url: "https://github.com/pirishd/InstantMock", majorVersion: 2, minor: 2)
    ]
)
```

## Inspiration

* Argument Capture: [Mockito](http://mockito.org/)
* Registration API: [SwiftMock](https://github.com/mflint/SwiftMock)

## Author
Patrick Irlande - pirishd@icloud.com

## License
*InstantMock* is available under the [MIT License](LICENSE).
