# SVGRenderer

[![Carthage compatible](https://img.shields.io/badge/Carthage-✓-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/SVGRenderer.svg?style=flat)](http://cocoapods.org/pods/SVGRenderer)
[![License](https://img.shields.io/cocoapods/l/SVGRenderer.svg?style=flat)](http://cocoapods.org/pods/SVGRenderer)
[![Language](https://img.shields.io/badge/language-swift_4.0-ff69b4.svg)](http://cocoadocs.org/docsets/SVGRenderer)
[![Platform](https://img.shields.io/cocoapods/p/SVGRenderer.svg?style=flat)](http://cocoapods.org/pods/SVGRenderer)

## Installation

**Cocoapods**

```ruby
pod "SVGRenderer", "1.0.0"
```

**Carthage**

```ruby
github "shaps80/SVGRenderer" ~> 1.0.0
```

## Introduction

<img src="sample.png" />

SVGRenderer is also cross-platform with iOS and macOS demo projects included in the repo. 

## Example

There are 2 example projects included in the repo. One for iOS and another for OSX.

Simply select the appropriate scheme, build and run.

Lets start by creating a simple drawing function:

```swift
func performDrawing<Context: RendererContext>(context: Context) {
	let rect = context.format.bounds
    UIColor.white.setFill()
    context.fill(rect)
    
    UIColor.blue.setStroke()
    let frame = CGRect(x: 10, y: 10, width: 40, height: 40)
    context.stroke(frame)
    
    UIColor.red.setStroke()
    context.stroke(rect.insetBy(dx: 5, dy: 5))
}
```

## Requirements

The library has the following requirements:

* Swift 4.0+
* iOS 8.0+
* OSX 10.10+

## Author

Shaps Benkau, shapsuk@me.com

## License

SVGRenderer is available under the MIT license. See the LICENSE file for more info.
