#
# Be sure to run `pod lib lint ROSelector.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ROSelector"
  s.version          = "0.0.3"
  s.summary          = "Highly customizable dropdown view."
  s.description      = <<-DESC
                       A drag and drop, customizable, dropdown view.
                       DESC
  s.homepage         = "https://github.com/Rounded/ROSelector"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Heather Snepenger" => "hs@roundedco.com" }
  s.source           = { :git => "https://github.com/Rounded/ROSelector.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ROSelector' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'PureLayout'
end
