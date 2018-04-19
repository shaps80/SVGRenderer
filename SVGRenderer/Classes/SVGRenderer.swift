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

/**
 *  Represents a new SVG renderer context
 */
public final class SVGRendererContext: RendererContext {
    
    /// The associated format
    public let format: SVGRendererFormat
    
    /// The associated CGContext
    public var cgContext: SVGContext {
        return svgContext
    }

    public let svgContext: SVGContext
    
    /// Returns a UIImage representing the current state of the renderer's CGContext
    public var currentImage: Image {
        return ImageRenderer(bounds: format.bounds).image { [weak self] context in
            self?.svgContext.render(in: context.cgContext)
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
        self.svgContext = cgContext
    }
    
}

/**
 *  Represents an image renderer used for drawing into a UIImage
 */
public final class SVGRenderer: Renderer {

    /// The associated context type
    public typealias Context = SVGRendererContext
    
    public let format: SVGRendererFormat
    internal let viewBox: CGRect

    public init(bounds: CGRect) {
        self.format = SVGRendererFormat(bounds: bounds)
        self.viewBox = bounds
    }
    
    public init(size: CGSize, viewBox: CGRect) {
        self.format = SVGRendererFormat(bounds: CGRect(origin: .zero, size: size))
        self.viewBox = viewBox
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
        let svgContext = SVGContext(id: nil, class: nil)
        let context = Context(format: format, cgContext: svgContext)
        actions(context)
        let viewBox = "\(format.bounds.minX) \(format.bounds.minY) \(format.bounds.width) \(format.bounds.height)"
        let fillRule = context.cgContext.usesEvenOddFillRule ? "evenodd" : "nonzero"
        
        return """
        <svg width="\(format.bounds.width)px" height="\(format.bounds.height)px" viewBox="\(viewBox)" xmlns="http://www.w3.org/2000/svg">
        <!-- Generator: SVGRenderer (1.1.0) - http://github.com/shaps80/SVGRenderer -->
        <path fill="#7F7F7F" fill-rule="\(fillRule)" d=\"\(svgContext.path.cgPath.svgString())\"></path>
        </svg>

        """
    }
    
    public func svgData(actions: (Context) -> Void) -> Data {
        return svgString(actions: actions).data(using: .utf8) ?? Data()
    }
    
}
