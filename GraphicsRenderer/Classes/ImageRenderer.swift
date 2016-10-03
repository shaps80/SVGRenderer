//
//  ImageRenderer.swift
//  GraphicsRenderer
//
//  Created by Shaps Benkau on 02/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Represents an image renderer format
 */
public struct ImageRendererFormat: RendererFormat {

    /**
     Returns a default format, configured for this device
     
     - returns: A new format
     */
    public static func `default`() -> ImageRendererFormat {
        return ImageRendererFormat(flipped: false)
    }
    
    /// Returns the bounds for this format
    public let bounds: CGRect
    
    /// Get/set whether or not the resulting image should be opaque
    public var opaque: Bool
    
    /// Get/set the scale of the resulting image
    public var scale: CGFloat
    
    /// Get/set whether or not the context should be flipped while drawing
    public var isFlipped: Bool
    
    /**
     Creates a new format with the specified bounds
     
     - parameter bounds: The bounds of this format
     - parameter opaque: Whether or not the resulting image should be opaque
     - parameter scale:  The scale of the resulting image
     
     - returns: A new format
     */
    public init(bounds: CGRect = .zero, opaque: Bool = false, scale: CGFloat = screenScale(), flipped: Bool) {
        self.bounds = bounds
        self.opaque = opaque
        self.scale = scale
        self.isFlipped = flipped
    }
}

/**
 *  Represents a new renderer context
 */
public struct ImageRendererContext: RendererContext {
    
    /// The associated format
    public let format: ImageRendererFormat
    
    /// The associated CGContext
    public let cgContext: CGContext
    
    /// Returns a UIImage representing the current state of the renderer's CGContext
    public var currentImage: Image {
        #if os(OSX)
            let cgImage = CGContext.current!.makeImage()!
            return NSImage(cgImage: cgImage, size: format.bounds.size)
        #else
            return UIGraphicsGetImageFromCurrentImageContext()!
        #endif
    }
    
    /**
     Creates a new renderer context
     
     - parameter format:    The format for this context
     - parameter cgContext: The associated CGContext to use for all drawing
     
     - returns: A new renderer context
     */
    internal init(format: ImageRendererFormat, cgContext: CGContext) {
        self.format = format
        self.cgContext = cgContext
    }
    
}

/**
 *  Represents an image renderer used for drawing into a UIImage
 */
public struct ImageRenderer: Renderer {
    
    /// The associated context type
    public typealias Context = ImageRendererContext
    
    /// Returns true
    public let allowsImageOutput: Bool = true
    
    /// Returns the format for this renderer
    public let format: ImageRendererFormat
    
    /**
     Creates a new renderer with the specified size and format
     
     - parameter size:   The size of the resulting image
     - parameter format: The format, provides additional options for this renderer
     
     - returns: A new image renderer
     */
    public init(size: CGSize, format: ImageRendererFormat? = nil) {
        var flipped = false
        
        #if os(OSX)
            flipped = true
        #endif
        
        self.format = format ?? ImageRendererFormat(bounds: CGRect(origin: .zero, size: size), flipped: flipped)
    }
    
    /**
     By default this method does nothing.
     */
    public static func prepare(_ context: CGContext, with rendererContext: ImageRendererContext) { }
    
    /**
     By default this returns nil
     */
    public static func context(with format: ImageRendererFormat) -> CGContext? { return nil }

    /**
     Returns a new image with the specified drawing actions applied
     
     - parameter actions: The drawing actions to apply
     
     - returns: A new image
     */
    public func image(actions: (Context) -> Void) -> Image {
        var image: Image?
        
        try? runDrawingActions(actions) { context in
            image = context.currentImage
        }
        
        return image!
    }
    
    /**
     Returns a PNG data representation of the resulting image
     
     - parameter actions: The drawing actions to apply
     
     - returns: A PNG data representation
     */
    public func pngData(actions: (Context) -> Void) -> Data {
        let image = self.image(actions: actions)
        return image.pngRepresentation()!
    }
    
    /**
     Returns a JPEG data representation of the resulting image
     
     - parameter actions: The drawing actions to apply
     
     - returns: A JPEG data representation
     */
    public func jpegData(withCompressionQuality compressionQuality: CGFloat, actions: (Context) -> Void) -> Data {
        let image = self.image(actions: actions)
        return image.jpgRepresentation(quality: compressionQuality)!
    }
    
    private func runDrawingActions(_ drawingActions: (Context) -> Void, completionActions: ((Context) -> Void)? = nil) throws {
        #if os(OSX)
            let bitmap = NSImage(size: format.bounds.size)
            bitmap.lockFocusFlipped(format.isFlipped)
            let cgContext = CGContext.current!
            let context = Context(format: self.format, cgContext: cgContext)
            drawingActions(context)
            completionActions?(context)
            bitmap.unlockFocus()
        #endif
        
        #if os(iOS)
            UIGraphicsBeginImageContextWithOptions(format.bounds.size, format.opaque, format.scale)
            let cgContext = CGContext.current!
            let context = Context(format: self.format, cgContext: cgContext, drawableImage: nil)
            drawingActions(context)
            completionActions?(context)
            UIGraphicsEndImageContext()
        #endif
    }
}