Pod::Spec.new do |spec|
  spec.name           = 'cocos2d-x'
  spec.version        = '3.16.0'
  spec.summary        = 'cocos2d-x'
  spec.description    = 'cocos2d-x'

  spec.homepage       = 'https://github.com/Senspark/cocos2d-x-3.15'

  # spec.license        = { :type => 'MIT', :file => 'FILE_LICENSE' }
  spec.author         = 'cocos2d-x'

  spec.ios.deployment_target = '7.0'
  spec.osx.deployment_target = '10.7'

  spec.default_subspecs = 'cocos_prebuilt'

  spec.source = {
    :git => 'https://github.com/Senspark/cocos2d-x-lite.git',
    :branch => 'master'
  }

  spec.ios.frameworks = 
    'CoreMotion',
    'Foundation',
    'GameController',
    'MediaPlayer'

  spec.osx.frameworks =
    'Foundation',
    'GameController'

  spec.library =
    'z',
    'iconv'

  spec.requires_arc = false
  spec.header_mappings_dir = '.'

  spec.prepare_command = <<-CMD
    echo settings set target.source-map /Volumes/Setup/Android/projects/senspark/sde2/cocos2d/ $(pwd) > ~/.lldbinit-Xcode
    echo Y | 7z x prebuilt/libs/ios/libcocos2d-x-debug.7z   -oprebuilt/libs/ios
    echo Y | 7z x prebuilt/libs/ios/libcocos2d-x-release.7z -oprebuilt/libs/ios
    echo Y | 7z x prebuilt/libs/mac/libcocos2d-x-debug.7z   -oprebuilt/libs/mac
    echo Y | 7z x prebuilt/libs/mac/libcocos2d-x-release.7z -oprebuilt/libs/mac
  CMD

  spec.subspec 'cocos_macros' do |s|
    s.preserve_path = 'dummy_path'
    s.xcconfig = { 
      'GCC_PREPROCESSOR_DEFINITIONS[config=Debug]' => [
        'COCOS2D_DEBUG=1',
        'USE_FILE32API'
      ].join(' '),
      'GCC_PREPROCESSOR_DEFINITIONS[config=Release]' => [
        'NDEBUG',
        'USE_FILE32API'
      ].join(' ')
    }
    s.ios.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => [
        'CC_TARGET_OS_IPHONE'
      ].join(' ')
    }
    s.osx.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => [
        'CC_TARGET_OS_MAC',
        'CC_KEYBOARD_SUPPORT',
        '_USRDLL'
      ].join(' ')
    }
  end

  spec.subspec 'cocos2dx_prebuilt_base' do |s|
    s.preserve_paths =
      'cocos/**/*.{cpp,m,mm}',
      'extensions/**/*.cpp',
      'external/clipper/*/cpp',
      'external/ConvertUTF/*.{c,cpp}',
      'external/edtaa3func/*.{c,cpp}',
      'external/md5/*.c',
      'external/poly2tri/**/*.cc',
      'external/recast/**/*.cpp',
      'external/tinyxml2/**.cpp',
      'external/unzip/*.cpp',
      'external/xxhash/*.c',
      'external/xxtea/*.cpp'

    s.xcconfig = {
      'HEADER_SEARCH_PATHS' => [
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/cocos',
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/extension',
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/external',
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/poly2tri'
      ].join(' '),
      'OTHER_LDFLAGS[config=Debug]'   => '$(inherited) -l"cocos2d-x-debug"',
      'OTHER_LDFLAGS[config=Release]' => '$(inherited) -l"cocos2d-x-release"'
    }

    s.dependency 'cocos2d-x/cocos2dx_macros_individual'
    s.dependency 'cocos2d-x/bullet_prebuilt_static'
    s.dependency 'cocos2d-x/curl_prebuilt_static'
    s.dependency 'cocos2d-x/freetype2_prebuilt_static'
    s.dependency 'cocos2d-x/jpeg_prebuilt_static'
    s.dependency 'cocos2d-x/png_prebuilt_static'
    s.dependency 'cocos2d-x/rapidjson_header_static'
    s.dependency 'cocos2d-x/rapidxml_header_static'
    s.dependency 'cocos2d-x/tiff_prebuilt_static'
    s.dependency 'cocos2d-x/webp_prebuilt_static'
    s.dependency 'cocos2d-x/websockets_prebuilt_static'

    s.osx.dependency 'cocos2d-x/glfw_prebuilt_static'
  end

  spec.subspec 'cocos_prebuilt' do |s|
    s.ios.public_header_files = 'prebuilt/include/ios/**/*'
    s.osx.public_header_files = 'prebuilt/include/mac/**/*'

    s.ios.header_mappings_dir = 'prebuilt/include/ios'
    s.osx.header_mappings_dir = 'prebuilt/include/mac'

    s.ios.vendored_library = 'prebuilt/libs/ios/*.a'
    s.osx.vendored_library = 'prebuilt/libs/mac/*.a'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/prebuilt/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/prebuilt/include/mac' }

    s.dependency 'cocos2d-x/cocos_macros'
    s.dependency 'cocos2d-x/cocos2dx_prebuilt_base'
  end

  spec.subspec 'cocos_internal_static' do |s|
    s.source_files =
      'cocos/cocos2d.{h,cpp}',
      'cocos/2d/*.{h,cpp}',
      'cocos/base/**/*.{h,c,cpp,mm}',
      'cocos/deprecated/*.{h,cpp}',
      'cocos/math/*.{h,inl,cpp}',
      'cocos/platform/*.{h,cpp}',
      'cocos/platform/apple/*',
      'cocos/renderer/*.{h,cpp,frag,vert}'

    s.ios.source_files =
      'cocos/platform/ios/*'

    s.osx.source_files =
      'cocos/platform/mac/*',
      'cocos/platform/desktop/*'

    s.public_header_files =
      'cocos/cocos2d.h',
      'cocos/2d/*.h',
      'cocos/base/**/*.h',
      'cocos/deprecated/*.h',
      'cocos/math/*.{h,inl}',
      'cocos/platform/*.h',
      'cocos/platform/apple/*.h',
      'cocos/renderer/*.{h,frag,vert}'

    s.ios.public_header_files =
      'cocos/platform/ios/*.h'

    s.osx.public_header_files =
      'cocos/platform/mac/*.h',
      'cocos/platform/desktop/*.h'
    
    s.osx.dependency 'cocos2d-x/glfw_prebuilt_static'

    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x' }

    s.dependency 'cocos2d-x/cocos_macros'
  end

  spec.subspec 'cocos_external_static' do |s|
    s.source_files =
      'external/ConvertUTF/*',
      'external/md5/*',
      'external/tinyxml2/*',
      'external/unzip/*',
      'external/edtaa3func/*',
      'external/xxhash/*',
      'external/poly2tri/**/*',
      'external/clipper/*',
      'external/tinydir/*.h'

    s.public_header_files =
      'external/ConvertUTF/*.h',
      'external/md5/*.h',
      'external/tinyxml2/*.h',
      'external/unzip/*.h',
      'external/edtaa3func/*.h',
      'external/xxhash/*',
      'external/poly2tri/**/*.h',
      'external/clipper/*.hpp',
      'external/tinydir/*.h'

    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external' }

    s.dependency 'cocos2d-x/cocos_macros'
  end

  spec.subspec 'cocos_static' do |s|
    s.dependency 'cocos2d-x/cocos_internal_static'
    s.dependency 'cocos2d-x/cocos_external_static'

    s.dependency 'cocos2d-x/audioengine_static'
    s.dependency 'cocos2d-x/cocosbuilder_static'
    s.dependency 'cocos2d-x/spine_static'
    s.dependency 'cocos2d-x/cocos_network_static'
    s.dependency 'cocos2d-x/cocos_ui_static'

    s.dependency 'cocos2d-x/bullet_prebuilt_static'
    s.dependency 'cocos2d-x/curl_prebuilt_static'
    s.dependency 'cocos2d-x/freetype2_prebuilt_static'
    s.dependency 'cocos2d-x/jpeg_prebuilt_static'
    s.dependency 'cocos2d-x/png_prebuilt_static'
    s.dependency 'cocos2d-x/rapidjson_header_static'
    s.dependency 'cocos2d-x/rapidxml_header_static'
    s.dependency 'cocos2d-x/tiff_prebuilt_static'
    s.dependency 'cocos2d-x/webp_prebuilt_static'
    s.dependency 'cocos2d-x/websockets_prebuilt_static'
  end

  spec.subspec 'audioengine_static' do |s|
    s.source_files =
      'cocos/audio/include/*',
      'cocos/audio/apple/*',
      'cocos/audio/AudioEngine.cpp'
    s.ios.source_files = 'cocos/audio/ios/*'
    s.osx.source_files = 'cocos/audio/mac/*'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/cocos' }
  end

  spec.subspec 'cocosbuilder_static' do |s|
    s.source_files = 'cocos/editor-support/cocosbuilder/*.{h,cpp}'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/cocos' }
    s.dependency 'cocos2d-x/cocos_extension_static'
  end

  spec.subspec 'spine_static' do |s|
    s.source_files = 'cocos/editor-support/spine/*.{c,cpp,h}'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/cocos/editor-support' }
    s.dependency 'cocos2d-x/cocos_internal_static'
  end

  spec.subspec 'cocos_network_static' do |s|
    s.source_files = 'cocos/network/*.{h,cpp,m,mm}'

    s.exclude_files =
      '*/**/*{android,winrt}*'
      'cocos/network/HttpClient.cpp'

    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/cocos' }

    s.dependency 'cocos2d-x/cocos_internal_static'
    s.dependency 'cocos2d-x/websockets_prebuilt_static'
  end

  spec.subspec 'cocos_ui_static' do |s|
    s.source_files =
      'cocos/ui/*.{h,cpp,mm}',
      'cocos/ui/UIEditBox/*.{h,cpp,mm}',

      # Used in CocosGUI.h
      'cocos/editor-support/cocostudio/CocosStudioExtension.h'

    s.ios.source_files = 'cocos/ui/UIEditBox/iOS/*'
    s.osx.source_files = 'cocos/ui/UIEditBox/Mac/*'

    s.exclude_files =
      'cocos/ui/UIWebView.cpp',
      '*/**/*{android}*'

    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/cocos' }

    s.dependency 'cocos2d-x/cocos_extension_static'
  end

  spec.subspec 'cocos_extension_static' do |s|
    s.source_files =
      'extensions/*.{h,cpp}',
      'extensions/assets-manager/*',
      'extensions/GUI/**/*'

    s.dependency 'cocos2d-x/cocos_internal_static'
    s.dependency 'cocos2d-x/cocos_network_static'
  end

  spec.subspec 'bullet_prebuilt_static' do |s|
    s.public_header_files = 'external/bullet/include/**/*'
    s.ios.vendored_library = 'external/bullet/prebuilt/ios/*'
    s.osx.vendored_library = 'external/bullet/prebuilt/mac/*'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/bullet/include' }
  end

  spec.subspec 'curl_prebuilt_static' do |s|
    s.ios.public_header_files = 'external/curl/include/ios/curl/*'
    s.osx.public_header_files = 'external/curl/include/mac/curl/*'

    s.ios.vendored_library = 'external/curl/prebuilt/ios/*'
    s.osx.vendored_library = 'external/curl/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/curl/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/curl/include/mac' }

    s.dependency 'cocos2d-x/openssl_prebuilt_static'
  end

  spec.subspec 'freetype2_prebuilt_static' do |s|
    s.ios.public_header_files = 'external/freetype2/include/ios/freetype2/**/*'
    s.osx.public_header_files = 'external/freetype2/include/mac/freetype2/**/*'

    s.ios.vendored_library = 'external/freetype2/prebuilt/ios/*'
    s.osx.vendored_library = 'external/freetype2/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/freetype2/include/ios/freetype2' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/freetype2/include/mac/freetype2' }
  end

  spec.subspec 'glfw_prebuilt_static' do |s|
    s.platform = :osx
    s.public_header_files = 'external/glfw3/include/mac/*'
    s.vendored_library = 'external/glfw3/prebuilt/mac/*'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/glfw3/include/mac' }
  end

  spec.subspec 'jpeg_prebuilt_static' do |s|
    s.ios.public_header_files = 'external/jpeg/include/ios/*'
    s.osx.public_header_files = 'external/jpeg/include/mac/*'

    s.ios.vendored_library = 'external/jpeg/prebuilt/ios/*'
    s.osx.vendored_library = 'external/jpeg/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/jpeg/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/jpeg/include/mac' }
  end

  spec.subspec 'openssl_prebuilt_static' do |s|
    s.ios.public_header_files = 'external/openssl/include/ios/openssl/*'
    s.osx.public_header_files = 'external/openssl/include/mac/openssl/*'

    s.ios.vendored_library = 'external/openssl/prebuilt/ios/*'
    s.osx.vendored_library = 'external/openssl/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/openssl/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/openssl/include/mac' }
  end

  spec.subspec 'png_prebuilt_static' do |s|
    s.ios.public_header_files = 'external/png/include/ios/*'
    s.osx.public_header_files = 'external/png/include/mac/*'

    s.ios.vendored_library = 'external/png/prebuilt/ios/*'
    s.osx.vendored_library = 'external/png/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/png/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/png/include/mac' }
  end

  spec.subspec 'rapidjson_header_static' do |s|
    s.preserve_path = 'dummy_path'
    s.public_header_files = 'external/json/**/*'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external' }
  end

  spec.subspec 'rapidxml_header_static' do |s|
    s.preserve_path = 'dummy_path'
    s.public_header_files = 'external/rapidxml/*'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external' }
  end

  spec.subspec 'tiff_prebuilt_static' do |s|
    s.ios.public_header_files = 'external/tiff/include/ios/*'
    s.osx.public_header_files = 'external/tiff/include/mac/*'

    s.ios.vendored_library = 'external/tiff/prebuilt/ios/*'
    s.osx.vendored_library = 'external/tiff/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/tiff/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/tiff/include/mac' }
  end

  spec.subspec 'webp_prebuilt_static' do |s|
    s.ios.public_header_files = 'external/webp/include/ios/*'
    s.osx.public_header_files = 'external/webp/include/mac/*'

    s.ios.vendored_library = 'external/webp/prebuilt/ios/*'
    s.osx.vendored_library = 'external/webp/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/webp/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/webp/include/mac' }
  end

  spec.subspec 'websockets_prebuilt_static' do |s|
    s.ios.public_header_files = 'external/websockets/include/ios/*'
    s.osx.public_header_files = 'external/websockets/include/mac/*'

    s.ios.vendored_library = 'external/websockets/prebuilt/ios/*'
    s.osx.vendored_library = 'external/websockets/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/websockets/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/websockets/include/mac' }

    s.dependency 'cocos2d-x/openssl_prebuilt_static'
  end
end
