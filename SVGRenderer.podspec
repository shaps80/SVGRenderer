Pod::Spec.new do |s|
    s.name             = "SVGRenderer"
    s.version          = "0.1.0"
    s.summary          = "An SVG renderer using the familiar GraphicsRenderer API"
    s.homepage         = "https://github.com/shaps80/SVGRenderer"
    s.license          = 'MIT'
    s.author           = { "Shaps" => "shapsuk@me.com" }
    s.source           = { :git => "https://github.com/shaps80/SVGRenderer.git", :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/shaps'
    s.platforms = { :ios => "8.0", :osx => "10.10" }
    s.requires_arc     = true
    s.source_files     = 'SVGRenderer/Classes/**/*'
    s.dependency 'GraphicsRenderer', '~> 1.3.0'
end
