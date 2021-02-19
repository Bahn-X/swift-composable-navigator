PLATFORM_IOS = iOS Simulator,name=iPhone 8

default: test

test:
	swift package generate-xcodeproj
	xcodebuild test -scheme swift-composable-navigator-Package \
	 	-derivedDataPath ./Build -enableCodeCoverage YES \
	 	-destination platform="$(PLATFORM_IOS)"

cleanup:
	rm -rf ./Build
	rm -rf ./swift-composable-navigator.xcodeproj
	rm -rf ./xcov_report

release:
	swift run rocket ${version}

.PHONY: test cleanup release
