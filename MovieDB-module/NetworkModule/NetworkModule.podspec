Pod::Spec.new do |s|
s.name         = "NetworkModule"
s.version      = "0.0.1"
s.summary      = "A short description of swift-ios-framework."
s.homepage     = "http://git.gits.id/RnD/swift-ios-framework"
s.license      = "MIT (ios)"
s.author             = { "GITS Indonesia" => "ajie@gits.co.id" }
s.source       = { :git => "https://git.gits.id/RnD/swift-ios-framework.git", :tag => "#{s.version}" }
s.source_files  = "NetworkModule/Classes/**/*.{h,m,swift}"
s.resource_bundles = {'NetworkModule' => ['NetworkModule/Assets/**/*.{storyboard,xib,xcassets,json,imageset,png}']}
s.platform         = :ios, "9.0"
s.dependency 'Alamofire'
s.dependency 'SwiftyJSON', '~>4.1.0'

end
