//
//  Platforms.swift
//  GraphicsRenderer-iOS
//
//  Created by Shaps Benkau on 04/04/2018.
//

#if os(OSX)
import AppKit
public typealias BezierPath = NSBezierPath
public typealias LineCapStyle = NSBezierPath.LineCapStyle
public typealias LineJoinStyle = NSBezierPath.LineJoinStyle
#else
import UIKit
public typealias BezierPath = UIBezierPath
public typealias LineCapStyle = CGLineCap
public typealias LineJoinStyle = CGLineJoin
#endif
