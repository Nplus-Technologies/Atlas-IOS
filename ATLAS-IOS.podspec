Pod::Spec.new do |s|
  s.name             = 'ATLAS-IOS'
  s.version          = '1.0'
  s.summary          = 'Place Search'
 
  s.description      = <<-DESC
Place Search listed out within a Tableview and
selected Place is converted to Location(Latitude&Longitude) using Geocoding!
                       DESC
 
  s.homepage         = 'https://github.com/Nplus-Technologies/Atlas-IOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '<Ram Kumar>' => '<ramnplus@gmail.com>' }
  s.source           = { :git => 'https://github.com/Nplus-Technologies/Atlas-IOS.git', :tag => s.version.to_s }
 
  s.swift_version = '5'
  s.requires_arc = true
  s.framework  = "Foundation"
  s.ios.framework = "UIKit"
  s.dependency 'Alamofire'
  s.dependency 'IQKeyboardManagerSwift'
  s.ios.deployment_target = '11.0'
  s.source_files = 'ATLAS','ATLAS/*.{swift}'

end