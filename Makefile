PLATFORM_IOS = iOS Simulator,name=iPhone 8

test:
	bundle exec fastlane test

cleanup:
	rm -rf ./Build
	rm -rf ./swift-composable-navigator.xcodeproj
	rm -rf ./fastlane/xcov_report

release:
	swift run rocket ${version}

.PHONY: test cleanup release