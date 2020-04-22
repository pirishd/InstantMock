#!/bin/bash

# download swift on Linux
if [[ $TRAVIS_OS_NAME = 'linux' ]]; then
  wget https://swift.org/builds/swift-5.2-release/ubuntu1804/swift-5.2-RELEASE/swift-5.2-RELEASE-ubuntu18.04.tar.gz
  tar xzf swift-5.2-RELEASE-ubuntu18.04.tar.gz
  export PATH="${PWD}/swift-5.2-RELEASE-ubuntu18.04/usr/bin:$PATH"
fi
