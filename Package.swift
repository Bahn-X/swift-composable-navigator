// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-composable-navigator",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "ComposableNavigator",
      targets: ["ComposableNavigator"]
    ),
    .library(
      name: "ComposableNavigatorTCA",
      targets: ["ComposableNavigatorTCA"]
    ),
  ],
  dependencies: [
    .package(
      name: "swift-composable-architecture",
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      from: "0.7.0"
    ),
  ],
  targets: [
    .target(
      name: "ComposableNavigator",
      dependencies: []
    ),
    .target(
      name: "ComposableNavigatorTCA",
      dependencies: [
        .target(name: "ComposableNavigator"),
        .product(
          name: "ComposableArchitecture",
          package: "swift-composable-architecture"
        ),
      ]
    ),
    .target(
      name: "ComposableDeeplinking",
      dependencies: [
        .target(name: "ComposableNavigator")
      ]
    ),
    .testTarget(
      name: "ComposableNavigatorTests",
      dependencies: [
        "ComposableNavigator",
      ]
    ),
    .testTarget(
      name: "ComposableDeeplinkingTests",
      dependencies: [
        "ComposableDeeplinking",
      ]
    )
  ]
)
