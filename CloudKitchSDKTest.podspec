

Pod::Spec.new do |spec|

  spec.name         = "CloudKitchSDKTest"
  spec.version      = "1.0.0"
  spec.summary      = "A sample test sdk for Cloudkitch"
  spec.description  = "A sample test sdk for Cloudkitch"

  spec.homepage     = "https://github.com/Codetreasure-tech/CloudKitchSDKTest"
  
  spec.license      = "MIT"
  
  spec.author             = { "Codetresure-tech" => "tech@codetreasure.com" }
  
  spec.platform     = :ios, "10.1"


  spec.source       = { :git => "https://github.com/Codetreasure-tech/CloudKitchSDKTest.git", :tag => spec.version.to_s}


  spec.source_files  = "CloudKitchSDKTest/**/*.{swift}"

  spec.swift_versions = "5.0"

end
