// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let snapshotFolders = [
  "PathBuilder/__Snapshots__",
  "Screen/__Snapshots__",
]

let testGybFiles = [
  "PathBuilder/PathBuilder+AnyOfTests.swift.gyb",
]

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
      name: "ComposableDeeplinking",
      targets: ["ComposableDeeplinking"]
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
    .package(url: "https://github.com/shibapm/Rocket", from: "1.1.0"), // dev
    .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.8.2"), // dev
  ],
  targets: [
    .target(
      name: "ComposableNavigator",
      dependencies: [],
      exclude: [
        "PathBuilder/PathBuilders/PathBuilder+AnyOf.swift.gyb",
      ]
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
        .target(name: "ComposableNavigator"),
      ]
    ),
    .testTarget(name: "ComposableNavigatorTests", dependencies: ["ComposableNavigator", "SnapshotTesting"], exclude: testGybFiles + snapshotFolders), // dev
    .testTarget(name: "ComposableDeeplinkingTests", dependencies: ["ComposableDeeplinking"]), // dev
    .testTarget(name: "ComposableNavigatorTCATests", dependencies: ["ComposableNavigatorTCA"]), // dev
  ]
)

#if canImport(PackageConfig)
import PackageConfig

let config = PackageConfiguration(
  [
    "rocket": [
      "pre_release_checks": [
        "clean_git"
      ],
      "before": [
        "make test",
        "make cleanup",
      ]
    ]
  ]
)
.write()
#endif
