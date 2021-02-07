Pod::Spec.new do |s|
  s.name             = 'UIScrollingLabel'
  s.version          = '1.0.0'
  s.summary          = 'Automatically Scrolled Label'
  
  s.description      = <<-DESC
      Automatically Scrolled Label.
  DESC
  
  s.homepage         = 'https://github.com/sulioppa/UIScrollingLabel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'author' => 'sulioppa@icloud.com' }
  s.source           = { :git => 'https://github.com/sulioppa/UIScrollingLabel.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'UIScrollingLabel/**/*'
  s.dependency 'Masonry'
  
end
