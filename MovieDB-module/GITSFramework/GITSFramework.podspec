Pod::Spec.new do |s|
s.name         = "GITSFramework"
s.version      = "0.0.3"
s.summary      = "A short description of swift-ios-framework."
s.homepage     = "http://git.gits.id/RnD/swift-ios-framework"
s.license      = "MIT (ios)"
s.author             = { "GITS Indonesia" => "yatnosudar@gits.co.id" }
s.source       = { :git => "http://git.gits.id/RnD/swift-ios-framework.git", :tag => "#{s.version}" }
s.source_files  = "GITSFramework/Classes/**/*.{h,m,swift}"
s.resource_bundles = {'GITSFramework' => ['GITSFramework/Assets/**/*.{storyboard,xib,xcassets,json,imageset,png,plist}']}
s.resource = 'GITSFramework/Assets/**'
s.platform         = :ios, "9.0"
s.dependency 'NetworkModule'
s.dependency 'Alamofire', '~>4.7.2'
s.dependency 'IQKeyboardManager'
s.dependency 'GITSRest'
s.dependency 'SDWebImage'
s.dependency 'SDWebImage/GIF'
s.dependency 'SwiftyJSON', '~>4.1.0'
s.dependency 'SwiftMessages', '~>6.0.2'
s.dependency 'HexColors', '~>6.0.0'
s.dependency 'SkyFloatingLabelTextField'
s.dependency 'SBPickerSelector', '~>1.2.0'
s.dependency 'ChameleonFramework/Swift' , '~>2.2.0'
s.dependency 'M13Checkbox', '~>3.2.2'
s.dependency 'Material', '~> 2.16'



end
