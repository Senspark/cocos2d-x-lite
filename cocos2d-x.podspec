Pod::Spec.new do |spec|
  spec.name           = 'cocos2d-x'
  spec.version        = '3.15.0'
  spec.summary        = 'cocos2d-x'
  spec.description    = 'cocos2d-x'

  spec.homepage       = 'https://github.com/Senspark/cocos2d-x-3.15'

  # spec.license        = { :type => 'MIT', :file => 'FILE_LICENSE' }
  spec.author         = 'cocos2d-x'

  spec.ios.deployment_target = '7.0'
  spec.osx.deployment_target = '10.7'

  spec.source = {
    :git => 'https://github.com/Senspark/cocos2d-x-3.15.git',
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

  spec.subspec 'search_path_cocos' do |s|
    s.preserve_path = 'dummy_path'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/cocos' }
  end

  spec.subspec 'search_path_external' do |s|
    s.preserve_path = 'dummy_path'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external' }
  end

  spec.subspec 'cocos2dx_macros_debug' do |s|
    s.preserve_path = 'dummy_path'
    s.xcconfig = { 
      'GCC_PREPROCESSOR_DEFINITIONS' => [
        'COCOS2D_DEBUG=1',
        'USE_FILE32API'
      ].join(' '),
    }
  end

  spec.subspec 'cocos2dx_macros_release' do |s|
    s.preserve_path = 'dummy_path'
    s.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => [
        'NDEBUG',
        'USE_FILE32API'
      ].join(' ')
    }
  end

  spec.subspec 'cocos2dx_macros_common' do |s|
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
  end

  spec.subspec 'cocos2dx_macros_individual' do |s|
    s.preserve_path = 'dummy_path'
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
    s.osx.preserve_path = 'prebuilt/include/mac'

    # s.osx.source_files = 'prebuilt/include/mac/**/*'
    s.osx.public_header_files = 'prebuilt/include/mac/**/*'
    s.osx.header_mappings_dir = 'prebuilt/include/mac'

    s.xcconfig = {
      'HEADER_SEARCH_PATHS' => [
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/cocos',
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/cocos/editor-support',
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/extension',
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/external',
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/poly2tri'
      ].join(' ')
    }

    s.dependency 'cocos2d-x/cocos2dx_macros_individual'
    s.dependency 'cocos2d-x/cocos_curl_static'
    s.dependency 'cocos2d-x/websockets_static'
    s.dependency 'cocos2d-x/cocos_chipmunk_static'
    s.dependency 'cocos2d-x/cocos_webp_static'
    s.dependency 'cocos2d-x/cocos_tiff_static'
    s.dependency 'cocos2d-x/cocos_png_static'
    s.dependency 'cocos2d-x/cocos_jpeg_static'
    s.dependency 'cocos2d-x/cocos_freetype2_static'

    s.osx.dependency 'cocos2d-x/glfw_static'
  end

  spec.subspec 'debug' do |s|
    s.osx.vendored_library = 'prebuilt/libs/mac/libcocos2d-x-debug.a'
    s.dependency 'cocos2d-x/cocos2dx_prebuilt_base'
    s.dependency 'cocos2d-x/cocos2dx_macros_debug'
  end
 
  spec.subspec 'release' do |s|
    s.osx.vendored_library = 'prebuilt/libs/mac/libcocos2d-x-release.a'
    s.dependency 'cocos2d-x/cocos2dx_prebuilt_base'
    s.dependency 'cocos2d-x/cocos2dx_macros_release'
  end

  spec.subspec 'cocos2dx_internal_static' do |s|
    s.source_files =
      'cocos/cocos2d.{h,cpp}',
      'cocos/2d/*.{h,cpp}',
      'cocos/3d/CCAABB.{h,cpp}',
      'cocos/3d/CCAnimate3D.h',
      'cocos/3d/CCFrustum.{h,cpp}',
      'cocos/3d/CCOBB.{h,cpp}',
      'cocos/3d/CCPlane.{h,cpp}',
      'cocos/platform/*.{h,cpp}',
      'cocos/math/*.{h,inl,cpp}',
      'cocos/base/**/*.{h,c,cpp,mm}',
      'cocos/renderer/*.{h,cpp,frag,vert}',
      'cocos/vr/*.{h,cpp,mm}',
      'cocos/deprecated/*.{h,cpp}',
      'cocos/physics/*.{h,cpp}',
      'cocos/physics3d/*.{h,cpp}',
      'cocos/navmesh/*.{h,cpp}',
      'external/ConvertUTF/*',
      'external/md5/*',
      'external/tinyxml2/*',
      'external/unzip/*',
      'external/edtaa3func/*',
      'external/xxhash/*',
      'external/poly2tri/**/*',
      'external/clipper/*',
      'external/tinydir/*'

    s.exclude_files = 'cocos/vr/CCVRGenericHeadTracker.cpp'

    s.public_header_files =
      'cocos/cocos2d.h',
      'cocos/2d/*.h',

      # Used in CCConfiguration.h
      'cocos/3d/CCAnimate3D.h',
      'cocos/3d/CCAnimation3D.h',
      'cocos/3d/CCAnimationCurve.h',
      'cocos/3d/CCAnimationCurve.inl',
      'cocos/3d/CCBundle3DData.h',

      # Used in CCCamera.h
      'cocos/3d/CCAABB.h',
      'cocos/3d/CCFrustum.h',
      'cocos/3d/CCOBB.h',
      'cocos/3d/CCPlane.h',

      # Used in CCPhysicsSprite.h
      'cocos/3d/CCBundle3DData.h',
      'cocos/3d/CCMeshVertexIndexData.h',
      'cocos/3d/CCSkeleton3D.h',
      'cocos/3d/CCSprite3D.h',

      'cocos/platform/*.h',
      'cocos/math/*.{h,inl}',
      'cocos/base/**/*.h',
      'cocos/renderer/*.{h,frag,vert}',
      'cocos/vr/*.h',
      'cocos/deprecated/*.h',
      'cocos/physics/*.h',
      'cocos/physics3d/*.h',
      'cocos/navmesh/*.h',
      'external/ConvertUTF/*.h',
      'external/md5/*.h',
      'external/tinyxml2/*.h',
      'external/unzip/*.h',
      'external/edtaa3func/*.h',
      'external/xxhash/*',
      'external/poly2tri/**/*.h',
      'external/clipper/*.hpp',

      # Used in CCFileUtils.cpp
      'external/tinydir/*'

    s.xcconfig = {
      'HEADER_SEARCH_PATHS' => [
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/poly2tri'
      ].join(' ')
    }

    s.dependency 'cocos2d-x/search_path_cocos'
    s.dependency 'cocos2d-x/search_path_external'
    s.dependency 'cocos2d-x/cocos2dx_macros_common'
    s.dependency 'cocos2d-x/cocos2dx_macros_individual'

    s.dependency 'cocos2d-x/cocos_freetype2_static'
    s.dependency 'cocos2d-x/cocos_jpeg_static'
    s.dependency 'cocos2d-x/cocos_png_static'
    s.dependency 'cocos2d-x/cocos_tiff_static'
    s.dependency 'cocos2d-x/cocos_webp_static'
    s.dependency 'cocos2d-x/rapidjson_static'
    s.dependency 'cocos2d-x/rapidxml_static'
    s.dependency 'cocos2d-x/cocos2dx_platform_static'

    # Optional
    s.dependency 'cocos2d-x/recast_static'
    s.dependency 'cocos2d-x/bullet_static'
    s.dependency 'cocos2d-x/cocos_chipmunk_static'
  end

  spec.subspec 'cocos2dx_static' do |s|
    s.dependency 'cocos2d-x/cocos2dx_internal_static'
    s.dependency 'cocos2d-x/audioengine_static'

    # Optional
    s.dependency 'cocos2d-x/cocos3d_static'
    s.dependency 'cocos2d-x/cocosbuilder_static'
    s.dependency 'cocos2d-x/cocos_network_static'
    s.dependency 'cocos2d-x/cocos_ui_static'
    s.dependency 'cocos2d-x/spine_static'
    s.dependency 'cocos2d-x/cocos_curl_static'
  end

  spec.subspec 'cocos2dx_platform_base_static' do |s|
    s.source_files = 'cocos/platform/apple/*'
    s.dependency 'cocos2d-x/search_path_cocos'
  end

  spec.subspec 'cocos2dx_platform_static' do |s|
    s.ios.source_files = 'cocos/platform/ios/*'
    s.osx.source_files = 'cocos/platform/mac/*', 'cocos/platform/desktop/*'
    s.dependency 'cocos2d-x/cocos2dx_platform_base_static'
    s.osx.dependency 'cocos2d-x/glfw_static'
  end

  spec.subspec 'audioengine_base_static' do |s|
    s.source_files =
      'cocos/audio/include/*',
      'cocos/audio/apple/*',
      'cocos/audio/AudioEngine.cpp'
  end

  spec.subspec 'audioengine_static' do |s|
    s.ios.source_files = 'cocos/audio/ios/*'
    s.osx.source_files = 'cocos/audio/mac/*'
    s.dependency 'cocos2d-x/audioengine_base_static'
  end

  spec.subspec 'spine_static' do |s|
    s.source_files = 'cocos/editor-support/spine/*.{c,cpp,h}'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/cocos/editor-support' }
    s.dependency 'cocos2d-x/cocos2dx_internal_static'
  end

  spec.subspec 'cocos_ui_base_static' do |s|
    s.source_files =
      'cocos/ui/*.{h,cpp,mm}',
      'cocos/ui/UIEditBox/*.{h,cpp,mm}',

      # Used in CocosGUI.h
      'cocos/editor-support/cocostudio/CocosStudioExtension.h'

    s.exclude_files =
      'cocos/ui/UIWebView.cpp',
      'cocos/ui/UIWebViewImpl-tizen.cpp',
      '*/**/*{android}*'

    s.dependency 'cocos2d-x/cocos_extension_static'
  end

  spec.subspec 'cocos_ui_static' do |s|
    s.ios.source_files = 'cocos/ui/UIEditBox/iOS/*'
    s.osx.source_files = 'cocos/ui/UIEditBox/Mac/*'
    s.dependency 'cocos2d-x/cocos_ui_base_static'
  end

  spec.subspec 'cocos_freetype2_static' do |s|
    s.preserve_path = 'external/freetype2/include/{ios,mac}'

    s.ios.public_header_files = 'external/freetype2/include/ios/freetype2/**/*'
    s.osx.public_header_files = 'external/freetype2/include/mac/freetype2/**/*'

    s.ios.vendored_library = 'external/freetype2/prebuilt/ios/*'
    s.osx.vendored_library = 'external/freetype2/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/freetype2/include/ios/freetype2' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/freetype2/include/mac/freetype2' }
  end

  spec.subspec 'cocos_jpeg_static' do |s|
    s.preserve_path = 'external/jpeg/include/{ios,mac}'

    s.ios.public_header_files = 'external/jpeg/include/ios/*'
    s.osx.public_header_files = 'external/jpeg/include/mac/*'

    s.ios.vendored_library = 'external/jpeg/prebuilt/ios/*'
    s.osx.vendored_library = 'external/jpeg/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/jpeg/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/jpeg/include/mac' }
  end

  spec.subspec 'cocos_png_static' do |s|
    s.preserve_path = 'external/png/include/{ios,mac}'

    s.ios.public_header_files = 'external/png/include/ios/*'
    s.osx.public_header_files = 'external/png/include/mac/*'

    s.ios.vendored_library = 'external/png/prebuilt/ios/*'
    s.osx.vendored_library = 'external/png/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/png/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/png/include/mac' }
  end

  spec.subspec 'cocos_tiff_static' do |s|
    s.preserve_path = 'external/tiff/include/{ios,mac}'

    s.ios.public_header_files = 'external/tiff/include/ios/*'
    s.osx.public_header_files = 'external/tiff/include/mac/*'

    s.ios.vendored_library = 'external/tiff/prebuilt/ios/*'
    s.osx.vendored_library = 'external/tiff/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/tiff/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/tiff/include/mac' }
  end

  spec.subspec 'cocos_webp_static' do |s|
    s.preserve_path = 'external/webp/include/{ios,mac}'

    s.ios.public_header_files = 'external/webp/include/ios/*'
    s.osx.public_header_files = 'external/webp/include/mac/*'

    s.ios.vendored_library = 'external/webp/prebuilt/ios/*'
    s.osx.vendored_library = 'external/webp/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/webp/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/webp/include/mac' }
  end

  spec.subspec 'cocos_chipmunk_static' do |s|
    s.preserve_path = 'external/chipmunk/include'

    s.public_header_files = 'external/chipmunk/include/chipmunk/*.h'

    s.ios.vendored_library = 'external/chipmunk/prebuilt/ios/*'
    s.osx.vendored_library = 'external/chipmunk/prebuilt/mac/*'

    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/chipmunk/include' }
  end

  spec.subspec 'websockets_static' do |s|
    s.preserve_path = 'external/websockets/include/{ios,mac}'

    s.ios.public_header_files = 'external/websockets/include/ios/*'
    s.osx.public_header_files = 'external/websockets/include/mac/*'

    s.ios.vendored_library = 'external/websockets/prebuilt/ios/*'
    s.osx.vendored_library = 'external/websockets/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/websockets/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/websockets/include/mac' }

    s.dependency 'cocos2d-x/cocos_ssl_static'
    s.dependency 'cocos2d-x/cocos_crypto_static'
  end

  spec.subspec 'openssl_base_static' do |s|
    s.preserve_path = 'external/openssl/include/{ios,mac}'

    s.ios.public_header_files = 'external/openssl/include/ios/openssl/*'
    s.osx.public_header_files = 'external/openssl/include/mac/openssl/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/openssl/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/openssl/include/mac' }
  end

  spec.subspec 'cocos_crypto_static' do |s|
    s.ios.vendored_library = 'external/openssl/prebuilt/ios/libcrypto.a'
    s.osx.vendored_library = 'external/openssl/prebuilt/mac/libcrypto.a'
    s.dependency 'cocos2d-x/openssl_base_static'
  end

  spec.subspec 'cocos_ssl_static' do |s|
    s.ios.vendored_library = 'external/openssl/prebuilt/ios/libssl.a'
    s.osx.vendored_library = 'external/openssl/prebuilt/mac/libssl.a'
    s.dependency 'cocos2d-x/openssl_base_static'
  end

  spec.subspec 'cocos_curl_static' do |s|
    s.preserve_path = 'external/curl/include/{ios,mac}'

    s.ios.public_header_files = 'external/curl/include/ios/curl/*'
    s.osx.public_header_files = 'external/curl/include/mac/curl/*'

    s.ios.vendored_library = 'external/curl/prebuilt/ios/*'
    s.osx.vendored_library = 'external/curl/prebuilt/mac/*'

    s.ios.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/curl/include/ios' }
    s.osx.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/curl/include/mac' }

    s.dependency 'cocos2d-x/cocos_ssl_static'
    s.dependency 'cocos2d-x/cocos_crypto_static'
  end

  spec.subspec 'rapidjson_static' do |s|
    s.preserve_path = 'external/json'

    s.public_header_files =
      'external/json/*.h',
      'external/json/{error,internal}/*.h'

    s.dependency 'cocos2d-x/search_path_external'
  end

  spec.subspec 'rapidxml_static' do |s|
    s.preserve_path = 'external/rapidxml'
    s.public_header_files = 'external/rapidxml/*'
    s.dependency 'cocos2d-x/search_path_external'
  end

  spec.subspec 'cocos3d_static' do |s|
    s.source_files = 'cocos/3d/*.{h,inl,cpp}'
    s.public_header_files = 'cocos/3d/*.{h,inl}'
    s.dependency 'cocos2d-x/search_path_cocos'
    s.dependency 'cocos2d-x/rapidjson_static'
  end

  spec.subspec 'cocos_extension_static' do |s|
    s.source_files =
      'extensions/*.{h,cpp}',
      'extensions/assets-manager/*',
      'extensions/GUI/**/*',
      'extensions/physics-nodes/*'

    s.xcconfig = {
      'HEADER_SEARCH_PATHS' => [
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/extensions/',
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/extensions/GUI/CCControlExtension',
        '$(PODS_ROOT)/Headers/Public/cocos2d-x/extensions/GUI/CCScrollView'
      ].join(' ')
    }

    s.dependency 'cocos2d-x/cocos2dx_internal_static'
  end

  spec.subspec 'cocos_network_static' do |s|
    s.source_files = 'cocos/network/*.{h,cpp,m,mm}'
    s.exclude_files =
      '*/**/*{android,winrt}*'
      'cocos/network/HttpClient.cpp'
    s.dependency 'cocos2d-x/cocos2dx_internal_static'
    s.dependency 'cocos2d-x/websockets_static'
  end

  spec.subspec 'cocosbuilder_static' do |s|
    s.source_files = 'cocos/editor-support/cocosbuilder/*.{h,cpp}'
    s.dependency 'cocos2d-x/cocos_extension_static'
  end

  spec.subspec 'recast_static' do |s|
    s.source_files = 'external/recast/**/*.{h,c,cpp}'
    s.dependency 'cocos2d-x/search_path_external'
  end

  spec.subspec 'bullet_static' do |s|
    s.source_files =
      'external/bullet/*.h',
      'external/bullet/BulletCollision/**/*',
      'external/bullet/BulletDynamics/**/*',
      'external/bullet/LinearMath/**/*'

    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/bullet' }
    s.dependency 'cocos2d-x/search_path_external'
  end

  spec.subspec 'glfw_static' do |s|
    s.platform = :osx
    s.preserve_path = 'external/glfw3'
    s.public_header_files = 'external/glfw3/include/mac/*'
    s.vendored_library = 'external/glfw3/prebuilt/mac/*'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/cocos2d-x/external/glfw3/include/mac' }
  end
end