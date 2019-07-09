
Pod::Spec.new do |s|
  s.name             = 'JySignaturePanel'
  s.version          = '0.0.1'
  s.summary          = '简单的签名面板'
  s.description      = <<-DESC
一个简单的手势签名面板
                       DESC
  s.homepage         = 'https://github.com/JyHiting/JySignaturePanel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JyHiting' => '1575792978@qq.com' }
  s.source           = { :git => 'https://github.com/JyHiting/JySignaturePanel.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'JySignaturePanel/Classes/*.{h,m}'

end
