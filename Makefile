PLATFORM_IOS = iOS Simulator,name=iPhone 8

test:
	xcodebuild -resolvePackageDependencies \
		-workspace Example/Example.xcworkspace \
		-scheme Example \
		-derivedDataPath Build

	xcodebuild clean test \
		-workspace Example/Example.xcworkspace \
		-scheme Example \
		-testPlan FullTests \
		-derivedDataPath Build \
		-destination platform="$(PLATFORM_IOS)" \
		-enableCodeCoverage YES \
		-parallel-testing-enabled YES \
		-parallel-testing-worker-count 4 \
		-quiet \
		-resultBundlePath coverage/test_result.xcresult

cleanup:
	rm -rf ./Build
	rm -rf ./coverage

release:
	swift run rocket ${version}

.PHONY: test cleanup release