PLATFORM_IOS = iOS Simulator,name=iPhone 8

default: test

test:
	xcodebuild test -scheme Example -derivedDataPath ./Build -enableCodeCoverage YES -destination platform="$(PLATFORM_IOS)"

.PHONY: test