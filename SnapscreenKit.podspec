Pod::Spec.new do |s|
  s.name         = "SnapscreenKit"
  s.version      = '1.0.6'
  s.summary          = "iOS SDK for Snapscreen"
  s.homepage     = "https://github.com/snpscrn/sdk-ios"
  s.author       = { "Snapscreen" => "office@snapscreen.com" }
  s.source       = { :git => "https://github.com/snpscrn/sdk-ios.git", :tag => s.version }
  s.documentation_url = 'https://github.com/snpscrn/sdk-ios/SnapscreenKitDoc/index.html'
  s.requires_arc = true
  s.ios.deployment_target  = '8.0'
  s.compiler_flags = '-lc++', '-ObjC'
  s.resource = 'SnapscreenKit.bundle'
  s.ios.vendored_frameworks = 'SnapscreenKit.framework'
  s.frameworks = 'UIKit'
  s.exclude_files = 'SnapscreenKitDemo', 'SnapscreenKitDemo.xcodprojc', 'SnapscreenKitDoc'
end
