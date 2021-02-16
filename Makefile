PLATFORM_IOS = iOS Simulator,name=iPhone 8

default: test

test:
	xcodebuild test \
		-scheme ComposableNavigator \
		-destination platform="$(PLATFORM_IOS)"

format:
	swift format --in-place --recursive \
		./Example ./Package.swift ./Sources ./Tests

.PHONY: test format