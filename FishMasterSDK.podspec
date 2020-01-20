#
# Be sure to run `pod lib lint FishMasterSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FishMasterSDK'
  s.version          = '0.1.0'
  s.summary          = 'FishMaster SDK'

  s.description      = <<-DESC
  'FishMaster SDK'
                       DESC

  s.homepage         = 'https://github.com/yura-yatseyko/fish-master-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yura-yatseyko' => 'yura.yatseyko@volpis.com' }
  s.source           = { :git => 'https://github.com/yura-yatseyko/fish-master-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*.swift'
end
