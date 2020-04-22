#!/bin/bash

# run codecov on MacOS
if [[ $TRAVIS_OS_NAME = 'osx' ]]; then
  bash <(curl -s https://codecov.io/bash) -J '^InstantMock$';
fi
