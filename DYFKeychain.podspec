
Pod::Spec.new do |spec|
  spec.name         = "DYFKeychain"
  spec.version      = "1.2.0"
  spec.summary      = "[ObjC] A library for storing text and data in Keychain."

  spec.description  = <<-DESC
  TODU: [ObjC] This library is used to store text and data in Keychain securely for iOS, OS X, tvOS and watchOS.
  DESC

  spec.homepage      = "https://github.com/itenfay/DYFKeychain"
  # spec.screenshots = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  spec.license = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Tenfay" => "itenfay@163.com" }
  # Or just: spec.author  = "Tenfay"
  # spec.authors          = { "Tenfay" => "itenfay@163.com" }
  # spec.social_media_url = "https://twitter.com/Tenfay"

  # spec.platform   = :ios
  # spec.platform = :ios, "5.0"
  spec.ios.deployment_target 	 = "7.0"
  spec.osx.deployment_target 	 = "10.10"
  spec.watchos.deployment_target = "3.0"
  spec.tvos.deployment_target 	 = "9.0"

  spec.source = { :git => "https://github.com/itenfay/DYFKeychain.git", :tag => spec.version }

  spec.source_files    = "Keychain/*.{h,m}"
  spec.public_header_files = "Keychain/*.h"
  # spec.exclude_files = "Classes/Exclude"

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

  spec.framework    = "Security"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"
end
