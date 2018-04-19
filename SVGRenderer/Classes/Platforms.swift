//
//  Platforms.swift
//  GraphicsRenderer-iOS
//
//  Created by Shaps Benkau on 04/04/2018.
//

#if os(OSX)

import AppKit

public typealias BezierPath = NSBezierPath
public typealias Color = NSColor

internal typealias LineCapStyle = NSBezierPath.LineCapStyle
internal typealias LineJoinStyle = NSBezierPath.LineJoinStyle

extension CGLineCap {

    internal var platform: LineCapStyle {
        switch self {
        case .butt: return .buttLineCapStyle
        case .round: return .roundLineCapStyle
        case .square: return .squareLineCapStyle
        }
    }

}

extension CGLineJoin {

    internal var platform: LineJoinStyle {
        switch self {
        case .bevel: return .bevelLineJoinStyle
        case .miter: return .miterLineJoinStyle
        case .round: return .roundLineJoinStyle
        }
    }

}

#else

import UIKit

public typealias BezierPath = UIBezierPath
public typealias Color = UIColor

internal typealias LineCapStyle = CGLineCap
internal typealias LineJoinStyle = CGLineJoin

extension CGLineCap {

    internal var platform: LineCapStyle {
        switch self {
        case .butt: return .butt
        case .round: return .round
        case .square: return .square
        }
    }

}

extension CGLineJoin {

    internal var platform: LineJoinStyle {
        switch self {
        case .bevel: return .bevel
        case .miter: return .miter
        case .round: return .round
        }
    }

}

#endif

extension CGLineCap {

    internal init(rawValue: String) {
        switch rawValue {
        case kCALineCapButt: self = .butt
        case kCALineCapRound: self = .round
        case kCALineCapSquare: self = .square
        default: fatalError()
        }
    }

}

extension CGLineJoin {

    internal init(rawValue: String) {
        switch rawValue {
        case kCALineJoinMiter: self = .miter
        case kCALineJoinRound: self = .round
        case kCALineJoinBevel: self = .bevel
        default: fatalError()
        }
    }

}
