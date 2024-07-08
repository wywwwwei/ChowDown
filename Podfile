# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'ChowDown' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ChowDown
  pod 'Masonry'
  pod 'BlocksKit'
  pod 'AFNetworking'
  pod 'SDWebImage', '~> 5.0'
  pod 'WechatOpenSDK-XCFramework'
  pod 'IQKeyboardManager'
  pod 'SVProgressHUD'
  pod 'YNPageViewController'

  target 'ChowDownTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ChowDownUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.generated_projects.each do |project|
      project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
          end
      end
  end
end
