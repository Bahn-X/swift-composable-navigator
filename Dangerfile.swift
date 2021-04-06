import Danger
import DangerSwiftCoverage

let danger = Danger()

Coverage.xcodeBuildCoverage(
  .xcresultBundle("coverage/test_result.xcresult")
)
