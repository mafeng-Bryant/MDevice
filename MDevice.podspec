Pod::Spec.new do |s|
  s.name             = 'MDevice'
  s.version          = '1.0.1'
  s.summary          = 'MDevice'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/mafeng-Bryant/MDevice'
  s.license          = { :type => 'MIT', :file => 'LICENSE'}
  s.author           = { '1499603656@qq.com' => 'feng.ma@patpat.com'}
  s.source           = { :git => 'https://github.com/mafeng-Bryant/MDevice.git', :tag => s.version.to_s}
  s.ios.deployment_target = '9.0'
  s.source_files = 'MDevice/Classes/**/*'
  s.dependency 'MFStoreHelperKit', '~> 1.0.3'
end
