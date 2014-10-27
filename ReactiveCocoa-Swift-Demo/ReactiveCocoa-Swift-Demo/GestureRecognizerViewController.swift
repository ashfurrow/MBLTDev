//
//  GestureRecognizerViewController.swift
//  ReactiveCocoa-Swift-Demo
//
//  Created by Ash Furrow on 2014-10-27.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

import UIKit
import ReactiveCocoa

class GestureRecognizerViewController: UIViewController {
    @IBOutlet weak var boxView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UIPanGestureRecognizer()
        view.addGestureRecognizer(recognizer)
        
        RAC(boxView, "center") <~ recognizer.rac_gestureSignal().map({ (object) -> AnyObject! in
            let recognizer = object as UIPanGestureRecognizer
            return NSValue(CGPoint: recognizer.locationInView(recognizer.view))
        })
        
        RAC(boxView, "backgroundColor") <~ recognizer.rac_gestureSignal().map({ (object) -> AnyObject! in
            let recognizer = object as UIPanGestureRecognizer
            let location = recognizer.locationInView(recognizer.view)
            let bounds = recognizer.view!.bounds
            let hue = location.x / CGRectGetWidth(bounds)
            let brightness = location.y / CGRectGetHeight(bounds)
            return UIColor(hue: hue, saturation: 1, brightness: brightness, alpha: 1)
        })
        
        recognizer.rac_gestureSignal().subscribeNext { (object) -> Void in
            let recognizer = object as UIPanGestureRecognizer
            let location = recognizer.locationInView(recognizer.view)
            
            println("(\(location.x), \(location.y))")
        }
    }
}
