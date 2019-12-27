Pod::Spec.new do |s|
  s.name = "AnimatedView"
  s.version = "0.0.1"
  s.summary = "Resize view on tap"
  s.description = <<-DESC
                   * Resize view on tap, handle long tap
                   DESC
  s.homepage = "https://github.com/iSerg/UIAnimatedView"
  s.license = {
    :type => 'MIT',
    :file => 'LICENSE.md'
  }
  s.author = { "Serhii" => "madrudenko@gmail.com" }
  s.ios.deployment_target = '11.0'

  s.source = {
    :git => 'https://github.com/iSerg/UIAnimatedView.git',
    :tag => s.version.to_s
  }
  s.source_files = 'Source'
  s.requires_arc = true
end