# Spec for InstantMock Pod
Pod::Spec.new do |s|

  # Spec Metadata
  s.name         = "InstantMock"
  s.version      = "0.0.1"
  s.summary      = "InstantMock makes it easy to create and use mocks in Swift 3"

  # Description used to generate tags and improve search results.
  s.description  = <<-DESC
  					InstantMock aims at creating mocks easily in Swift 3. It provides a simple
  					way to mock, stub and verify expectations.
                   DESC

  s.homepage     = "https://github.com/pirishd/InstantMock"

  # Spec License 
  s.license      = "MIT"

  # Author Metadata
  s.author       = { "pirishd (Patrick Irlande)" => "pirishd@users.noreply.github.com" }

  # Source Location
  s.source       = { :git => "https://github.com/pirishd/InstantMock", :tag => "#{s.version}" }

  # Source Code
  s.source_files = "InstantMock/**/*.{h,m,swift}"
  s.requires_arc = true
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"

  # Project Linking
  s.frameworks   = 'XCTest'

end
