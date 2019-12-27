Pod::Spec.new do |s|
  s.name = "UIAnimatedView"
  s.version = "0.0.1"
  s.summary = "Resize view on tap"
  s.description = <<-DESC
                   * Resize view on tap, handle long tap
                   DESC
  s.homepage = "https://github.com/iSerg/UIAnimatedView"
  s.license = {
    :type => 'MIT',
    :file => 'LICENSE'
  }
  s.author = { "Serhii" => "madrudenko@gmail.com" }
  

  s.source = {
    :git => 'https://github.com/iSerg/UIAnimatedView.git',
    :tag => s.version.to_s
  }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Source/**'
  s.frameworks = 'UIKit'
  s.swift_version = '4.0'
end