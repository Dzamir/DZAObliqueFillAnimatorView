Pod::Spec.new do |s|
  s.name             = "DZAObliqueFillAnimatorView"
  s.version          = "0.1.0"
  s.summary          = "Custom view with an oblique transparent cut on the top"
  s.description      = <<-DESC
                       A custom view that haves an oblique transparent cut on the top and it can be filled with an animated circle
                       DESC
  s.homepage         = "https://github.com/Dzamir/DZAObliqueFillAnimatorView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Davide Di Stefano" => "dzamirro@gmail.com" }
  s.source           = { :git => "https://github.com/Dzamir/DZAObliqueFillAnimatorView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dzamir'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DZAObliqueFillAnimatorView' => ['Pod/Assets/*.png']
  }
end
