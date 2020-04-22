#!/bin/bash

# export path on Linux
if [[ $TRAVIS_OS_NAME = 'linux' ]]; then
  export PATH="${PWD}/swift-5.2-RELEASE-ubuntu18.04/usr/bin:$PATH"
fi

# build and test
swift build
swift test

# on MacOS, also run xcodebuild
if [[ $TRAVIS_OS_NAME = 'osx' ]]; then
  xcodebuild -scheme "InstantMock iOS" -workspace InstantMock.xcworkspace/ -destination 'platform=iOS Simulator,name=iPhone 11,OS=13.2.2' build test
fi
