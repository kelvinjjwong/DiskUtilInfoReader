Pod::Spec.new do |s|
  s.name        = "DiskUtilInfoReader"
  s.version     = "1.0.1"
  s.summary     = "A library for reading info from diskutil in macOS platform."
  s.homepage    = "https://github.com/kelvinjjwong/DiskUtilInfoReader"
  s.license     = { :type => "MIT" }
  s.authors     = { "kelvinjjwong" => "kelvinjjwong@outlook.com" }

  s.requires_arc = true
  s.swift_version = "5.0"
  s.osx.deployment_target = "14.0"
  s.source   = { :git => "https://github.com/kelvinjjwong/DiskUtilInfoReader.git", :tag => s.version }
  s.source_files = "Sources/DiskUtilInfoReader/**/*.swift"
end
