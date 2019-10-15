Pod::Spec.new do |s|
    s.name         = "ZZBullet"
    s.version      = "1.0.0"
    s.ios.deployment_target = '8.0'
    s.summary      = "A BulletView framework."
    s.homepage     = "https://github.com/814908848/BulletDemo"
    s.license              = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "814908848" => "814908848@qq.com" }
    s.source       = { :git => "https://github.com/814908848/BulletDemo.git", :tag => s.version }
    s.source_files  = "ZZBullet/*.{h,m}"
    s.resources          = "ZZBullet/ZZBundle.bundle"
    s.requires_arc = true
end