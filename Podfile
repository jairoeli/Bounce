# Uncomment the next line to define a global platform for your project
platform :ios, '10.3'

target 'Shotsgram' do
  use_frameworks!

  # Networking
  pod 'Alamofire'
  pod 'Moya/RxSwift'
  pod 'MoyaSugar/RxSwift'
  pod 'WebLinking', :git => 'https://github.com/kylef/WebLinking.swift',
                    :commit => 'fddbacc30deab8afe12ce1d3b78bd27c593a0c29'
  pod 'Kingfisher'

  # Model
  pod 'ObjectMapper'

  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RxOptional'
  pod 'RxKeyboard'
  pod 'RxSwiftUtilities'
  pod 'RxReusable'
  pod 'RxGesture'

  # UI
  pod 'SnapKit'
  pod 'ManualLayout'
  pod 'Immutable'
  pod 'TTTAttributedLabel'

  # Logging
  pod 'CocoaLumberjack/Swift'

  # Misc.
  pod 'Then'
  pod 'ReusableKit'
  pod 'CGFloatLiteral'
  pod 'SwiftyColor'
  pod 'SwiftyImage'
  pod 'UITextView+Placeholder'
  pod 'URLNavigator'
  pod 'KeychainAccess'

  target 'ShotsgramTests' do
    inherit! :search_paths

    pod 'RxTest'
    pod 'RxExpect'
  end

end
