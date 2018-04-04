//
//  SVGContext.swift
//  Pods
//
//  Created by Shaps Benkau on 04/04/2018.
//

#if os(iOS)

import UIKit

extension UIBezierPath: SVGContext {
    public func line(to point: CGPoint) {
        addLine(to: point)
    }
    
    public func curve(to endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
        addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }
    
    public func quadCurve(to endPoint: CGPoint, controlPoint: CGPoint) {
        addQuadCurve(to: endPoint, controlPoint: controlPoint)
    }
    
    public func arc(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }
    
    public func appendRect(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        append(path)
    }
    
    public func appendOval(in rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        append(path)
    }
    
}

#else

import AppKit

public extension NSBezierPath {
    
    var cgPath: CGPath {
        let path = CGMutablePath()
        let points = NSPointArray.allocate(capacity: 3)
        
        for i in 0 ..< elementCount {
            let type = element(at: i, associatedPoints: points)
            switch type {
            case .moveToBezierPathElement:
                path.move(to: points[0])
            case .lineToBezierPathElement:
                path.addLine(to: points[0])
            case .curveToBezierPathElement:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePathBezierPathElement:
                path.closeSubpath()
            }
        }
        
        return path
    }
    
}

extension NSBezierPath: SVGContext {
    
    public func apply(_ transform: CGAffineTransform) {
        let t = AffineTransform(m11: transform.a, m12: transform.b, m21: transform.c, m22: transform.d, tX: transform.tx, tY: transform.ty)
        self.transform(using: t)
    }
    
    public func quadCurve(to endPoint: CGPoint, controlPoint: CGPoint) {
        let (d1x, d1y) = (controlPoint.x - currentPoint.x, controlPoint.y - currentPoint.y)
        let (d2x, d2y) = (endPoint.x - controlPoint.x, endPoint.y - controlPoint.y)
        let cp1 = CGPoint(x: controlPoint.x - d1x / 3.0, y: controlPoint.y - d1y / 3.0)
        let cp2 = CGPoint(x: controlPoint.x + d2x / 3.0, y: controlPoint.y + d2y / 3.0)
        self.curve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    }
    
    public func arc(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        let _startAngle = startAngle * 180.0 / CGFloat(Double.pi)
        let _endAngle = endAngle * 180.0 / CGFloat(Double.pi)
        appendArc(withCenter: .zero, radius: radius, startAngle: _startAngle, endAngle: _endAngle, clockwise: !clockwise)
    }
    
    public var usesEvenOddFillRule: Bool {
        get { return windingRule == .evenOddWindingRule }
        set { windingRule = usesEvenOddFillRule ? .evenOddWindingRule : .nonZeroWindingRule }
    }
    
}

#endif
