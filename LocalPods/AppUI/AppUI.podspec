Pod::Spec.new do |s|
  s.name                  = "AppUI"
  s.version               = "0.1.0"
  s.summary               = "Custom UI elements for application"

  s.homepage              = "https://www.vanyaluk.com"
  s.authors               = 'iOSApp'
  s.source                = { :path => '*' }

  s.ios.deployment_target = '14.0'
  s.static_framework = true
  s.module_map = false
 
  s.source_files          = '**/*.{swift,h,n,xib,storyboard}'

end
