# Example Application and Test Suite

<p align="center"><img src="../Documentation/exampleapp.gif" width="40%"></img></p>

## Requirements
- Ruby
- Bundler
- Danger

## Example applications

```shell
open ./Example.xcworkspace
```

This repository contains two example applications.

The main example application is a TCA based application that covers complex navigation patterns. This application contains a UI test suite to ensure that future updates of SwiftUI do not break ComposableNavigator.

The vanilla example application is a simplified example to demonstrate the usage of ComposableNavigator in a Vanialla SwiftUI application.

Both applications can be accessed through the Example.xcworkspace. Change the scheme in Xcode to run either application.

## Tests

Run `make test` in the root folder.

## Cleanup

Run `make cleanup` to delete all test artifacts.