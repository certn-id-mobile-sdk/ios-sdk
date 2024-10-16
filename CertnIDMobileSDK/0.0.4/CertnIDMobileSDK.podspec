zipfile = "#{__dir__}/CertnIDMobileSDK.zip"

Pod::Spec.new do |s|
  s.name             = 'CertnIDMobileSDK'
  s.version          = '0.0.4'
  s.summary          = 'CertnIDMobileSDK is a powerful iOS library designed to streamline and secure the digital onboarding process. '

  s.description      = <<-DESC
  CertnIDMobileSDK is a powerful iOS library designed to streamline and secure the digital onboarding process. This SDK offers robust features for verifying identities, capturing and validating documents, and ensuring compliance with regulatory requirements.
                       DESC

  s.homepage         = 'https://github.com/certn-id-mobile-sdk/ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yuri Grigoriev' => 'yuri.grigoriev@igniform.com' }
  s.source           = { :http => "file://#{zipfile}"}

  s.ios.deployment_target = '12.0'
  s.ios.vendored_frameworks = "CertnIDMobileSDK.xcframework"

  s.dependency "dot-document"
  s.dependency "dot-face-detection-fast"
  s.dependency "dot-nfc"
  s.dependency "dot-face-detection-balanced"
end
