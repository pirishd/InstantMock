# InstantMock
## Create mocks easily in Swift 3

## Introduction
*InstantMock* aims at creating mocks easily in Swift 3. It provides a simple way to mock, stub and verify expectations.

This project is in beta for now. Suggestions and issue reports are welcome :)

## Usage

*InstantMock* works in two parts:
* **Mock Creation**: this is where you create your mocks.
* **Settings expectations and stubs**: this is where mocks are used in your actual tests.


### Mock Creation

#### Using Inheritance

The easiest way to create a mock, is to inherit from the `Mock` class.

The example below assumes we want to mock this protocol:
```Swift
protocol Foo {
    func bar(arg1: String, arg2: Int) -> Bool
}
```

In your test project, create a new class `FooMock` that inherits from `Mock` and adopts the `Foo` protocol: 

```Swift
class FooMock: Mock, Foo {

    // implement `bar`
    func bar(arg1: String, arg2: Int) -> Bool {
        return super.call(arg1, arg2)! // provide values to parent class
    }
    
}
```

#### Using Delegation

Often, inheritance cannot be used (for example when your mock must already inherit from another class). In this case, mocks are simply created by implementing the `MockDelegate` protocol.

The example below uses the same `Foo` protocol as above. 

In your test project, create a new class `FooMock` that adopts the `MockDelegate` and `Foo` protocols:

```Swift
class FooMock: MockDelegate, Foo {

    // create `Mock` delegate instance
    private let mock = Mock()
    
    // conform to the `MockDelegate` protocol by providing the `Mock` instance
    var it: Mock {
        return mock
    }

    // implement `bar` to conform to the `Foo` protocol
    func bar(arg1: String, arg2: Int) -> Bool {
        return mock.call(arg1, arg2)! // provide values to the delegate
    }
    
}
```

#### Return Values
Return values are handled in different ways, if optional or not.

Optional Value:
```Swift
func returnsOptional() -> Bool? {
    return mock.call()
}
```
Non-Optional Value of Common Type, see [MockUsable](#mockusable):
```Swift
func returnsMockUsable() -> Bool { // `Bool` adopts `MockUsable`
    return mock.call()! // force unwrapping the return value
}
```
Non-Optional Value of Custom Type:
```Swift
func returnsCustom() -> CustomType {
    return mock.call() ?? CustomType() // make sure to return a `CustomType` instance
}
```
#### Throwing
For catching errors on throwing methods in mocks, just use `callThrowable` instead of `call`. For example:
```Swift
func baz() throws -> Bool {
    return try mock.callThrowable()!
}
```

### Expectations

Expectations aim at verifying that a call is done with some arguments.

They are set using syntax like in the following example:
```Swift
let mock = FooMock()
mock.expect().call(mock.bar(arg1: Arg.eq("hello"), arg2: Arg<Int>.any))
```
Here, we expect `bar` to be called with "hello" and any Int as arguments.

##### Number of calls
In addition, expectations can be set on the number of calls:
```Swift
mock.expect().call(mock.bar(arg1: Arg.eq("hello"), arg2: Arg<Int>.any), count: 2)
```
Here, we expect `bar` to be called twice with "hello" and any Int as arguments.

##### Verifications
Verifying expectations is done this way:
```Swift
mock.verify()
```

### Stubs

Stubs aim at performing some actions when a function is called with some arguments. For example, they return a certain value or call other functions.

They are set using a syntax like in the following example:

```Swift
// set stub with return value
mock.stub().call(mock.bar(arg1: Arg.eq("hello"), arg2: Arg.eq(42))).andReturn(true)
````
Here, we stub `bar` to return `true` when called with "hello" and 42 as arguments.

#### Returning Values
This is done with `andReturn(…)` on a stub instance.

#### Computing a Return Value
This is done with `andReturn(closure: { _ in return … })` on a stub instance. That enables to return different values on the same stub, depending on some conditions.

#### Calling a Function
This is done with `andDo( { _ in … } )` on a stub instance.

#### Throwing an Error
This is done with `andThrow(…)` on a stub instance.

### Chaining
Chaining several actions on the same stub is possible, given they don't confict. For example, it is possible to return a value and call another function, like in `andReturn(true).andDo({ _ in print("something") })`.

*Rules:*
* the last closure registered by `andDo` is called first
* the last error registered by `andThrow` is thrown
* the last return value registered by `andReturn` is returned
* otherwise the last return value computation method, registered by `andReturn(closure:)`, is called

### Argument Matching

Registering expectations and stubs is based on arguments matching. They are executed only if arguments match what was configured.

#### Matching a Certain Value
This is done with `Arg.eq(…)`.

#### Matching any Values of a Given Type
This is done with `Arg<Type>.any`.

**Note:** only `MockUsable` types can match any values, see [here](#mockusable).

#### Matching a Certain Condition
This is done with `Arg.verify({ _  in return … })`.

#### Matching a Closure
Matching a closure is a special case.

Use the following syntax: `Arg.closure()`

### Argument Capturing

Arguments can be captured for later use using the `ArgumentCaptor` class.

For example:
```Swift
let captor = ArgumentCaptor<String>()
mock.expect().call(mock.bar(arg1: captor.capture(), arg2: Arg.eq(42)))
…
let value = captor.value
let values = captor.allValues
```
Here, we create an argument captor for type `String`. Values are registered, and are accessible for later use with `value` and `allValues` properties.

#### Capturing a closure

Capturing a closure is a special case. Use the following syntax:

```Swift
let captor = ArgumentClosureCaptor<(Int) -> Bool>()
…
let ret = captor.value!(42)
````
Here, we create an argument captor for type `(Int) -> Bool`. After having captured the closure, it can be called.

### MockUsable

`MockUsable` is a protocol that makes easy the use of a type in mocks.
For a given type, it enables returning non-nil values and catching any values in mocks.

Adding `MockUsable` on an existing type is done by creating an extension that adopts the protocol. For example:


```Swift
extension SomeClass: MockUsable {
    
    static var any = SomeClass() // any value
    
    // return any value
    static var anyValue: MockUsable {
        return SomeClass.any
    }

    // returns true if an object is equal to another `MockUsable` object
    func equal(to value: MockUsable) -> Bool {
        guard let value = value as? SomeClass else { return false }
        return self == value
    }

}
```

#### MockUsable types

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
* Xcode 8.2
* iOS 9
* osX 10.10

## Installation
### Cocoapods
*InstantMock* is available using [CocoaPods](http://cocoapods.org). Just add the following line to your Podfile:
```
pod 'InstantMock'
```

## Inspiration

* Argument Capture: [Mockito](http://mockito.org/)
* Registration API: [SwiftMock](https://github.com/mflint/SwiftMock)

## Author
Patrick Irlande - pirishd@yahoo.com

## License
*InstantMock* is available under the [MIT License](LICENSE).
