Pod::Spec.new do |s|
  s.name         = "DDTraitCollection"
  s.version      = "0.0.1"
  s.summary      = "UITraitCollections in iOS 7"
  s.description  = <<-DESC
                   DDTraitCollection aims to be a simple drop-in tool to make UITraitCollection available in iOS 7.
                   DESC
  s.homepage     = "https://github.com/vascoorey/DDTraitCollection"
  s.license      = "MIT"
  s.author             = { "Vasco d'Orey" => "vasco.orey@gmail.com" }
  s.social_media_url   = "https://twitter.com/oppfiz"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/vascoorey/DDTraitCollection.git", :tag => "0.0.1" }
  s.source_files  = "Source", "Source/**/*.{h,m}"
  s.framework  = "UIKit"
  s.requires_arc = true
end
