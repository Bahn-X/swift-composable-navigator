import Danger
import DangerSwiftCoverage  // package: https://github.com/f-meloni/danger-swift-coverage.git

let danger = Danger()

Coverage.xcodeBuildCoverage(
  .derivedDataFolder("Build"),
  excludedTargets: ["ComposableNavigatorTests.xctest", "ComposableDeeplinkingTests.xctest"]
)
