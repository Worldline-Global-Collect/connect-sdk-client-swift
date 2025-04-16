Pod::Spec.new do |s|

  s.name          = "WorldlineConnectKit"
  s.version       = "6.1.2"
  s.summary       = "Worldline Connect Swift SDK"
  s.description   = <<-DESC
                    This native Swift SDK facilitates handling payments in your apps
                    using the Worldline Global Collect platform of Worldline Global Collect.
                    DESC

  s.homepage      = "https://github.com/Worldline-Global-Collect/connect-sdk-client-swift"
  s.license       = { :type => "MIT", :file => "LICENSE.txt" }
  s.author        = "Worldline Connect"
  s.platform      = :ios, "12.0"
  s.source        = { :git => "https://github.com/Worldline-Global-Collect/connect-sdk-client-swift.git", :tag => s.version }
  s.source_files  = "WorldlineConnectKit/**/*.swift"
  s.resource      = "WorldlineConnectKit/WorldlineConnectKit.bundle", "WorldlineConnectKit/PrivacyInfo.xcprivacy"
  s.swift_version = "5"
  
  s.dependency 'Alamofire', '~> 5.4'
  s.dependency 'CryptoSwift', '1.4.0'
end
