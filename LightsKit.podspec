Pod::Spec.new do |s|
  s.name         = "LightsKit"
  s.version      = "1.0.5"
  s.summary      = "A short description of LightsKit."
  s.source       = { :git => "https://github.com/edc1591/LightsKit.git", :tag => "1.0.5" }

  s.source_files = 'LightsKit/*.{h,m}'

  s.requires_arc = true
  s.dependency 'SocketRocket'
  s.dependency 'AFNetworking'
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
end
