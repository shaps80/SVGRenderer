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

import UIKit
import SVGRenderer

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let string = SVGRenderer(size: CGSize(width: 50, height: 50)).svgString { context in
            let path = context.cgContext
            
            path.move(to: CGPoint(x: 12, y: 19.5))
            path.curve(to: CGPoint(x: 20.08, y: 13.63), controlPoint1: CGPoint(x: 12, y: 19.5), controlPoint2: CGPoint(x: 20.08, y: 13.63))
            path.line(to: CGPoint(x: 17, y: 4.12))
            path.line(to: CGPoint(x: 14.87, y: 4.12))
            path.curve(to: CGPoint(x: 15, y: 5), controlPoint1: CGPoint(x: 14.95, y: 4.4), controlPoint2: CGPoint(x: 15, y: 4.69))
            path.curve(to: CGPoint(x: 12, y: 8), controlPoint1: CGPoint(x: 15, y: 6.66), controlPoint2: CGPoint(x: 13.66, y: 8))
            path.curve(to: CGPoint(x: 9, y: 5), controlPoint1: CGPoint(x: 10.34, y: 8), controlPoint2: CGPoint(x: 9, y: 6.66))
            path.curve(to: CGPoint(x: 9.13, y: 4.12), controlPoint1: CGPoint(x: 9, y: 4.69), controlPoint2: CGPoint(x: 9.05, y: 4.4))
            path.line(to: CGPoint(x: 7, y: 4.12))
            path.line(to: CGPoint(x: 3.92, y: 13.63))
            path.line(to: CGPoint(x: 12, y: 19.5))
            path.line(to: CGPoint(x: 12, y: 19.5))
            path.close()
        }
        
        print(string)
    }
    
}
