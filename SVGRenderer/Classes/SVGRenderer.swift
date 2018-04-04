//
//  SVGRenderer.swift
//
//  Created by Shaps Benkau on 04/04/2018.
//  Copyright © 2018 152percent Ltd. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import AppKit
#endif

import GraphicsRenderer

/**
 *  Represents an SVG renderer format
 */
public final class SVGRendererFormat: RendererFormat {
    
    /**
     Returns a default format.
     
     - returns: A new format
     */
    public static func `default`() -> SVGRendererFormat {
        return SVGRendererFormat(bounds: .zero)
    }
    
    /// Returns the bounds for this format
    public var bounds: CGRect
    
    /**
     Creates a new format with the specified bounds
     
     - parameter bounds: The bounds of this format
     
     - returns: A new format
     */
    internal init(bounds: CGRect) {
        self.bounds = bounds
    }
    
}

public protocol SVGContext {
    func move(to point: CGPoint)
    func line(to point: CGPoint)
    
    func curve(to endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint)
    func quadCurve(to endPoint: CGPoint, controlPoint: CGPoint)
    func arc(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)

    func close()
    func apply(_ transform: CGAffineTransform)
    
    var lineWidth: CGFloat { get set }
    var lineCapStyle: LineCapStyle { get set }
    var lineJoinStyle: LineJoinStyle { get set }
    var miterLimit: CGFloat { get set }
    var usesEvenOddFillRule: Bool { get set }
    
    func setLineDash(_ pattern: UnsafePointer<CGFloat>?, count: Int, phase: CGFloat)
    
    func append(_ bezierPath: BezierPath)
    func appendRect(_ rect: CGRect)
    func appendOval(in rect: CGRect)
}

/**
 *  Represents a new SVG renderer context
 */
public final class SVGRendererContext: RendererContext {
    
    /// The associated format
    public let format: SVGRendererFormat
    
    /// The associated CGContext
    public let cgContext: SVGContext
    
    /// Returns a UIImage representing the current state of the renderer's CGContext
    public var currentImage: Image {
        return ImageRenderer(bounds: format.bounds).image { [weak self] context in
            guard let path = self?.cgContext as? BezierPath else { fatalError() }
            path.fill()
            path.stroke()
        }
    }
    
    /**
     Creates a new renderer context
     
     - parameter format:    The format for this context
     - parameter cgContext: The associated CGContext to use for all drawing
     
     - returns: A new renderer context
     */
    internal init(format: SVGRendererFormat, cgContext: SVGContext) {
        self.format = format
        self.cgContext = cgContext
    }
    
}

/**
 *  Represents an image renderer used for drawing into a UIImage
 */
public final class SVGRenderer: Renderer {

    /// The associated context type
    public typealias Context = SVGRendererContext
    
    public let format: SVGRendererFormat
    
    public init(bounds: CGRect) {
        self.format = SVGRendererFormat(bounds: bounds)
    }
    
    /**
     Creates a new renderer with the specified size and format
     
     - parameter size:   The size of the resulting SVG
     - parameter format: The format, provides additional options for this renderer
     
     - returns: A new image renderer
     */
    public convenience init(size: CGSize, format: SVGRendererFormat? = nil) {
        guard size != .zero else { fatalError("size cannot be zero") }
        
        let bounds = CGRect(origin: .zero, size: size)
        self.init(bounds: bounds)
    }
    
    public func svgString(actions: (Context) -> Void) -> String {
        let svgContext = BezierPath(rect: .zero)
        let context = Context(format: format, cgContext: svgContext)
        actions(context)
        let viewBox = "\(format.bounds.minX) \(format.bounds.minY) \(format.bounds.width) \(format.bounds.height)"
        let fillRule = context.cgContext.usesEvenOddFillRule ? "evenodd" : "nonzero"
        
        return """
        <svg width="\(format.bounds.width)px" height="\(format.bounds.height)px" viewBox="\(viewBox)" xmlns="http://www.w3.org/2000/svg">
        <!-- Generator: SVGRenderer (1.0.0) - http://github.com/shaps80/SVGRenderer -->
        <path fill="#7F7F7F" fill-rule="\(fillRule)" d=\"\(svgContext.cgPath.svgString())\"></path>
        </svg>

        """
    }
    
    public func svgData(actions: (Context) -> Void) -> Data {
        return svgString(actions: actions).data(using: .utf8) ?? Data()
    }
    
}
