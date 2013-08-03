Pod::Spec.new do |s|
  s.name         = "LightsKit"
  s.version      = "0.1"
  s.summary      = "A short description of LightsKit."
  s.source       = { :git => "https://github.com/edc1591/LightsKit.git", :tag => "0.1" }

  s.source_files = 'LightsKit/*.{h,m}'

  s.requires_arc = true
  s.dependency 'SocketRocket'
end
