//
//  SVGContext.swift
//  Pods
//
//  Created by Shaps Benkau on 19/04/2018.
//

import Foundation

public final class SVGContext {

    public var lineWidth: CGFloat = 0
    public var lineCapStyle: CGLineCap = .round
    public var lineJoinStyle: CGLineJoin = .round
    public var dashPhase: CGFloat = 0
    public var dashPattern: [CGFloat] = []

    public var usesEvenOddFillRule: Bool = false
    public var fillColor: Color? = .black
    public var strokeColor: Color? = nil

    internal let id: String?
    internal let `class`: String?

    internal let path = BezierPath()
    internal private(set) var groups: [SVGContext] = []

    internal init(id: String?, `class`: String?) {
        self.id = id
        self.class = `class`
    }

    public func group(id: String, `class`: String? = nil, _ actions: (SVGContext) -> Void) {
        let context = SVGContext(id: id, class: `class`)

        // inherit all the values
        context.lineWidth = lineWidth
        context.lineCapStyle = lineCapStyle
        context.lineJoinStyle = lineJoinStyle
        context.dashPhase = dashPhase
        context.dashPattern = dashPattern
        context.usesEvenOddFillRule = usesEvenOddFillRule
        context.fillColor = fillColor
        context.strokeColor = strokeColor

        actions(context)
        groups.append(context)
    }

    public func append(_ shape: CAShapeLayer) {
        path.append(shape)
    }

    public func append(_ bezierPath: BezierPath) {
        path.append(bezierPath)
    }

    public func append(_ cgPath: CGPath?) {
        path.append(cgPath)
    }

}

extension SVGContext {

    internal func render(in cgContext: CGContext) {
        cgContext.saveGState()

        if fillColor != nil || strokeColor != nil {
            cgContext.addPath(path.cgPath)
        }

        if let color = fillColor {
            cgContext.setFillColor(color.cgColor)
            cgContext.fillPath()
        }

        if let color = strokeColor, lineWidth > 0 {
            if !dashPattern.isEmpty {
                cgContext.setLineDash(phase: dashPhase, lengths: dashPattern)
            }

            cgContext.setLineWidth(lineWidth)
            cgContext.setLineCap(lineCapStyle)
            cgContext.setLineJoin(lineJoinStyle)
            cgContext.setStrokeColor(color.cgColor)
            cgContext.strokePath()
        }

        cgContext.restoreGState()

        groups.forEach {
            $0.render(in: cgContext)
        }
    }

}
