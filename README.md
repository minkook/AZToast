# AZToast

[![CI Status](https://img.shields.io/travis/minkook/AZToast.svg?style=flat)](https://travis-ci.org/minkook/AZToast)
[![Version](https://img.shields.io/cocoapods/v/AZToast.svg?style=flat)](https://cocoapods.org/pods/AZToast)
[![License](https://img.shields.io/cocoapods/l/AZToast.svg?style=flat)](https://cocoapods.org/pods/AZToast)
[![Platform](https://img.shields.io/cocoapods/p/AZToast.svg?style=flat)](https://cocoapods.org/pods/AZToast)


<p align="center">
      <img src="https://user-images.githubusercontent.com/2138712/201614979-486514c9-85dc-4743-bee6-5d8b3bbb1f19.gif" alt="AZToast" title="AZToast"> 
</p>


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AZToast is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AZToast'
```

## Usage

```swift
// Show Toast
AZToast(text: "토스트 입니다.").show()

// Show Toast & duration
AZToast(text: "토스트 입니다.").duration(3.0).show()

// Custom Theme
// Use AZToastTheme protocol
struct AZToastTheme_Custom: AZToastTheme {
    var duration: TimeInterval = 1.5
    
    var animateDuration: TimeInterval = 0.3
    
    var animateType: AZToastThemeAnimate = .slide
    
    var backgroundColor: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.7)
    
    var borderWidth: Double = 1.0
    
    var borderColor: UIColor = .black
    
    var cornerRadius: Double = 5.0
    
    var font: UIFont = UIFont.systemFont(ofSize: 16)
    
    var textColor: UIColor = .white
    
    var textAlignment: NSTextAlignment = .center
    
    var lineSpacing: Double = 5.0
    
    var icon: AZToastThemeIcon? = .init(image: UIImage(systemName: "heart"),
                                        size: CGSize(width: 32, height: 32),
                                        alignment: .left,
                                        textSpacing: 10.0)
    
    init() { }
}

// Set Custom Theme
AZToastConfig.shared.theme = AZToastTheme_Custom()

```

## Author

minkook, manguks@gmail.com

## License

AZToast is available under the MIT license. See the LICENSE file for more info.
