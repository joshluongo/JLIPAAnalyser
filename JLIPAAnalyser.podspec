Pod::Spec.new do |s|

  s.name         = "JLIPAAnalyser"
  s.version      = "1.0.1"
  s.summary      = "A simple IPA metadata reader"
  s.homepage     = 'https://github.com/joshluongo/JLIPAAnalyser'

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author    = "Joshua Luongo"
  s.social_media_url   = "http://twitter.com/joshluongo"

  s.ios.deployment_target = "6.0"
  s.osx.deployment_target = "10.8"

  s.source       = { :git => "https://github.com/joshluongo/JLIPAAnalyser.git", :tag => "v1.0.1" }

  s.source_files  = 'JLIPAAnalyser.{h,m}'

  s.dependency 'zipzap', '~> 8.0'

  s.requires_arc = true

end
