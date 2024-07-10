#
# Be sure to run `pod lib lint CertnIDMobileSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
zipfile = "#{__dir__}/CertnIDMobileSDK.zip"

Pod::Spec.new do |s|
  s.name             = 'CertnIDMobileSDK'
  s.version          = '0.0.7'
  s.summary          = 'CertnIDMobileSDK is a powerful iOS library designed to streamline and secure the digital onboarding process. '

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  CertnIDMobileSDK is a powerful iOS library designed to streamline and secure the digital onboarding process. This SDK offers robust features for verifying identities, capturing and validating documents, and ensuring compliance with regulatory requirements.
                       DESC

  s.homepage         = 'https://github.com/certn-id-mobile-sdk/ios-sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yuri Grigoriev' => 'yuri.grigoriev@zentity.com' }
  s.source           = { :http => "file://#{zipfile}"}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.ios.vendored_frameworks = "CertnIDMobileSDK.xcframework"

  s.dependency "dot-document"
  s.dependency "dot-face-detection-fast"
  s.dependency "dot-nfc"
  s.dependency "dot-face-detection-balanced"
end
