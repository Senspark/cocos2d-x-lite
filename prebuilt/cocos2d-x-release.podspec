Pod::Spec.new do |spec|
  spec.name           = 'cocos2d-x-release'
  spec.version        = '3.15.0'
  spec.summary        = 'cocos2d-x'
  spec.description    = 'cocos2d-x'

  spec.homepage       = 'https://github.com/Senspark/cocos2d-x-3.15'

  # spec.license        = { :type => 'MIT', :file => 'FILE_LICENSE' }
  spec.author         = 'cocos2d-x'

  spec.source = {
    :git => 'https://github.com/Senspark/cocos2d-x-3.15.git',
    :branch => 'master'
  }

  spec.dependency = 'cocos2d-x/release', local => '..'
end
