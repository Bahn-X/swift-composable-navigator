PLATFORM_IOS = iOS Simulator,name=iPhone 8

cleanup:
	rm -rf ./Build
	rm -rf ./fastlane/xcov_report

release:
	swift run rocket ${version}

.PHONY: cleanup release