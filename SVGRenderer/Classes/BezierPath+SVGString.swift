//
//  BezierPath+SVGString.swift
//  Pods
//
//  Created by Shaps Benkau on 04/04/2018.
//

import CoreGraphics
import GraphicsRenderer

extension CGPath {
    
    internal func svgString() -> String {
        var components: [String] = []
        
        forEach { element in
            let points = UnsafeBufferPointer(start: element.points, count: 3)
            
            switch element.type {
            case .moveToPoint:
                components.append("M\(points[0].x),\(points[0].y)")
            case .addLineToPoint:
                components.append("L\(points[0].x),\(points[0].y)")
            case .addCurveToPoint:
                components.append("C\(points[0].x),\(points[0].y),\(points[1].x),\(points[1].y),\(points[2].x),\(points[2].y)")
            case .addQuadCurveToPoint:
                components.append("Q\(points[0].x),\(points[0].y),\(points[1].x),\(points[1].y)")
            case .closeSubpath:
                components.append("Z")
            }
        }
        
        return components.joined(separator: " ")
    }
    
    /// Call the given closure on each element of the path.
    internal func forEach(_ body: @escaping (CGPathElement) -> Void) {
        var info = body
        self.apply(info: &info) { (infoPtr, elementPtr) in
            let opaquePtr = OpaquePointer(infoPtr!)
            let body = UnsafeMutablePointer<(CGPathElement) -> Void>(opaquePtr).pointee
            body(elementPtr.pointee)
        }
    }

    
}
