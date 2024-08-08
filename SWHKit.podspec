#
# Be sure to run `pod lib lint SWHKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SWHKit'
  s.version          = '1.0.1'
  s.summary          = 'A short description of SWHKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Snail-ww/SWHKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Snail-ww' => '1959049240@qq.com' }
  s.source           = { :git => 'https://github.com/Snail-ww/SWHKit.git', :tag => '1.0.0' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'SWHKit/Classes/**/*'
  
  s.resource_bundles = {
    'SWHKit' => ['SWHKit/Assets/**/*']
  }

  s.public_header_files = 'Pod/Classes/SWHKit.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'Masonry', '~> 1.1.0'
    s.dependency 'YYKit', '~> 1.0.9'
end
