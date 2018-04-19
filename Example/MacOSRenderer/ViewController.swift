/*
  Copyright © 03/10/2016 Snippex Ltd

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 */

import Cocoa
import SVGRenderer
import GraphicsRenderer

class ViewController: NSViewController {
    
    @IBOutlet weak var imageView: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let string = SVGRenderer(size: CGSize(width: 50, height: 50)).svgString { context in
            let frame = context.format.bounds
            let path = BezierPath()

            path.move(to: CGPoint(x: frame.minX + 24.9, y: frame.minY + 6.5))
            path.curve(to: CGPoint(x: frame.minX + 44.5, y: frame.minY + 20.63), controlPoint1: CGPoint(x: frame.minX + 24.89, y: frame.minY + 6.5), controlPoint2: CGPoint(x: frame.minX + 44.5, y: frame.minY + 20.63))
            path.line(to: CGPoint(x: frame.minX + 37.01, y: frame.minY + 43.5))
            path.line(to: CGPoint(x: frame.minX + 31.85, y: frame.minY + 43.5))
            path.curve(to: CGPoint(x: frame.minX + 32.17, y: frame.minY + 41.39), controlPoint1: CGPoint(x: frame.minX + 32.06, y: frame.minY + 42.83), controlPoint2: CGPoint(x: frame.minX + 32.17, y: frame.minY + 42.12))
            path.curve(to: CGPoint(x: frame.minX + 24.89, y: frame.minY + 34.17), controlPoint1: CGPoint(x: frame.minX + 32.17, y: frame.minY + 37.4), controlPoint2: CGPoint(x: frame.minX + 28.91, y: frame.minY + 34.17))
            path.curve(to: CGPoint(x: frame.minX + 17.62, y: frame.minY + 41.39), controlPoint1: CGPoint(x: frame.minX + 20.87, y: frame.minY + 34.17), controlPoint2: CGPoint(x: frame.minX + 17.62, y: frame.minY + 37.4))
            path.curve(to: CGPoint(x: frame.minX + 17.93, y: frame.minY + 43.5), controlPoint1: CGPoint(x: frame.minX + 17.62, y: frame.minY + 42.12), controlPoint2: CGPoint(x: frame.minX + 17.73, y: frame.minY + 42.83))
            path.line(to: CGPoint(x: frame.minX + 12.77, y: frame.minY + 43.5))
            path.line(to: CGPoint(x: frame.minX + 5.92, y: frame.minY + 20.63))
            path.line(to: CGPoint(x: frame.minX + 24.89, y: frame.minY + 6.5))
            path.line(to: CGPoint(x: frame.minX + 24.9, y: frame.minY + 6.5))
            path.close()

            context.svgContext.fillColor = .darkGray
//            context.svgContext.lineWidth = 1
            context.svgContext.strokeColor = Color.red
            context.svgContext.append(path)

            context.svgContext.group(id: "head") { context in
                let path = BezierPath(rect: CGRect(x: 0, y: 0, width: 20, height: 20))
                context.append(path)
            }

            let image = context.currentImage
            let filename = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true).first!
            let url = URL(fileURLWithPath: filename).appendingPathComponent("test.jpg")
            let rep = NSBitmapImageRep(data: image.tiffRepresentation!)?.representation(using: .png, properties: [.compressionFactor: 1])
            try? rep?.write(to: url)
        }
        
        print(string)
        
//        if let url = try? FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
//            let imageUrl = url.appendingPathComponent("image.svg")
//            try? string.data(using: .utf8)?.write(to: imageUrl)
//        }
    }

}
