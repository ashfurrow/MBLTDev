//
//  NetworkViewController.swift
//  ReactiveCocoa-Swift-Demo
//
//  Created by Ash Furrow on 2014-10-27.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

import UIKit
import ReactiveCocoa

let location = "http://static.ashfurrow.com/blog/tower.jpg"

class NetworkViewController: UIViewController {
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        RAC(imageView, "image") <~ goButton.rac_signalForControlEvents(.TouchUpInside).take(1).doNext { (_) -> Void in
            println("Starting download")
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }.then { () -> RACSignal! in
            let url = NSURL(string: location)!
            let request = NSURLRequest(URL: url)
            let networkSignal = NSURLConnection.rac_sendAsynchronousRequest(request).deliverOn(RACScheduler.mainThreadScheduler())
            return networkSignal
        }.map(toImage).doNext { (_) -> Void in
            println("Downloaded")
        }.catch { (error) -> RACSignal! in
            println("Encountered error: \(error)")
            return RACSignal.`return`(UIImage(named: "error"))
        }.doNext { (_) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}

func toImage(object: AnyObject!) -> AnyObject! {
    let tuple = object as RACTuple
    return UIImage(data: tuple.second as NSData)
}
