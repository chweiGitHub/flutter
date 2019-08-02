#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_umengshare'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.pod_target_xcconfig = {'SWIFT_VERSION' => '4,2' }
  s.ios.deployment_target = '8.0'

  s.static_framework = true
  s.requires_arc  = true

  s.dependency 'UMCCommon'

  s.dependency 'UMCSecurityPlugins'

  s.dependency 'UMCPush'

  s.dependency 'UMCCommonLog'

  # U-Share SDK UI模块（分享面板，建议添加）
  s.dependency 'UMCShare/UI'
  # 集成微信(完整版14.4M)
  s.dependency 'UMCShare/Social/WeChat'
  # 集成QQ/QZone/TIM(完整版7.6M)
  s.dependency 'UMCShare/Social/QQ'
  # 集成新浪微博(完整版25.3M)
  s.dependency 'UMCShare/Social/Sina'
  # 集成Facebook/Messenger
  s.dependency 'UMCShare/Social/Facebook'
  # 集成Twitter
  s.dependency 'UMCShare/Social/Twitter'
#  # 集成支付宝
#  s.dependency 'UMCShare/Social/AlipayShare'
#  # 集成钉钉
#  s.dependency 'UMCShare/Social/DingDing'
#  # 集成豆瓣
#  s.dependency 'UMCShare/Social/Douban'
#  # 集成人人
#  s.dependency 'UMCShare/Social/Renren'
#  # 集成腾讯微博
#  s.dependency 'UMCShare/Social/TencentWeibo'
#  # 集成易信
#  s.dependency 'UMCShare/Social/YiXin'
#  # 集成Flickr
#  s.dependency 'UMCShare/Social/Flickr'
#  # 集成Kakao
#  s.dependency 'UMCShare/Social/Kakao'
#  # 集成Tumblr
#  s.dependency 'UMCShare/Social/Tumblr'
#  # 集成Pinterest
#  s.dependency 'UMCShare/Social/Pinterest'
#  # 集成Instagram
#  s.dependency 'UMCShare/Social/Instagram'
#  # 集成Line
#  s.dependency 'UMCShare/Social/Line'
#  # 集成WhatsApp
#  s.dependency 'UMCShare/Social/WhatsApp'
#  # 集成有道云笔记
#  s.dependency 'UMCShare/Social/YouDao'
#  # 集成印象笔记
#  s.dependency 'UMCShare/Social/EverNote'
#  # 集成Google+
#  s.dependency 'UMCShare/Social/GooglePlus'
#  # 集成Pocket
#  s.dependency 'UMCShare/Social/Pocket'
#  # 集成DropBox
#  s.dependency 'UMCShare/Social/DropBox'
#  # 集成VKontakte
#  s.dependency 'UMCShare/Social/VKontakte'
  # 集成邮件
  s.dependency 'UMCShare/Social/Email'
  # 集成短信
  s.dependency 'UMCShare/Social/SMS'


end

