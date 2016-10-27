Pod::Spec.new do |s|
  s.name             = "SnapscreenKit"
  s.version          = "1.11.0"
  s.summary          = "iOS SDK for Snapscreen"
  s.description      = <<-DESC
                       SnapscreenKit provides clients of Snapscreen with access to the Snapscreen API and Snapping features.
                       DESC
  s.homepage         = "https://github.com/snpscrn/sdk-ios"
  s.author           = { "Snapscreen Application GmbH" => "office@snapscreen.com" }
  s.source           = { :git => "https://github.com/snpscrn/sdk-ios.git", :tag => s.version.to_s }
  s.license = 'MIT'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.vendored_frameworks = 'SnapscreenKit.framework'
  s.resource = 'SnapscreenKit.bundle'
  s.frameworks = 'UIKit'
end