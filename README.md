# SVGRenderer

[![Carthage compatible](https://img.shields.io/badge/Carthage-✓-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/SVGRenderer.svg?style=flat)](http://cocoapods.org/pods/SVGRenderer)
[![License](https://img.shields.io/cocoapods/l/SVGRenderer.svg?style=flat)](http://cocoapods.org/pods/SVGRenderer)
[![Language](https://img.shields.io/badge/language-swift_4.0-ff69b4.svg)](http://cocoadocs.org/docsets/SVGRenderer)
[![Platform](https://img.shields.io/cocoapods/p/SVGRenderer.svg?style=flat)](http://cocoapods.org/pods/SVGRenderer)

SVGRenderer is a cross-platform (iOS and macOS) library for making SVG's from paths in code.

## Example

<img src="image.png" />

Making the SVG above is as easy as drawing a path with a familiar API:

```swift
let string = SVGRenderer(size: CGSize(width: 50, height: 50)).svgString { context in
    let frame = context.format.bounds
    let path = context.cgContext
            
    path.move(to: NSPoint(x: frame.minX + 24.9, y: frame.minY + 6.5))
    path.curve(to: NSPoint(x: frame.minX + 44.5, y: frame.minY + 20.63), controlPoint1: NSPoint(x: frame.minX + 24.89, y: frame.minY + 6.5), controlPoint2: NSPoint(x: frame.minX + 44.5, y: frame.minY + 20.63))
    path.line(to: NSPoint(x: frame.minX + 37.01, y: frame.minY + 43.5))
    path.line(to: NSPoint(x: frame.minX + 31.85, y: frame.minY + 43.5))
    path.curve(to: NSPoint(x: frame.minX + 32.17, y: frame.minY + 41.39), controlPoint1: NSPoint(x: frame.minX + 32.06, y: frame.minY + 42.83), controlPoint2: NSPoint(x: frame.minX + 32.17, y: frame.minY + 42.12))
    path.curve(to: NSPoint(x: frame.minX + 24.89, y: frame.minY + 34.17), controlPoint1: NSPoint(x: frame.minX + 32.17, y: frame.minY + 37.4), controlPoint2: NSPoint(x: frame.minX + 28.91, y: frame.minY + 34.17))
    path.curve(to: NSPoint(x: frame.minX + 17.62, y: frame.minY + 41.39), controlPoint1: NSPoint(x: frame.minX + 20.87, y: frame.minY + 34.17), controlPoint2: NSPoint(x: frame.minX + 17.62, y: frame.minY + 37.4))
    path.curve(to: NSPoint(x: frame.minX + 17.93, y: frame.minY + 43.5), controlPoint1: NSPoint(x: frame.minX + 17.62, y: frame.minY + 42.12), controlPoint2: NSPoint(x: frame.minX + 17.73, y: frame.minY + 42.83))
    path.line(to: NSPoint(x: frame.minX + 12.77, y: frame.minY + 43.5))
    path.line(to: NSPoint(x: frame.minX + 5.92, y: frame.minY + 20.63))
    path.line(to: NSPoint(x: frame.minX + 24.89, y: frame.minY + 6.5))
    path.line(to: NSPoint(x: frame.minX + 24.9, y: frame.minY + 6.5))
    path.close()
}
    
print(string)
```

## Getting Started

### Installation

**Cocoapods**

```ruby
`pod "SVGRenderer", "1.0.0"`
```

**Carthage**

```ruby
github "shaps80/SVGRenderer" ~> 1.0.0
```

> There are 2 example projects included in the repo. One for iOS and another for OSX.  
Simply select the appropriate scheme, build and run.

## Requirements

* Swift 4.0+
* iOS 8.0+
* OSX 10.10+

## Author

Shaps Benkau, shapsuk@me.com

## License

SVGRenderer is available under the MIT license. See the LICENSE file for more info.
