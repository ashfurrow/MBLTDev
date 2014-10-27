//
//  LoginViewController.swift
//  ReactiveCocoa-Swift-Demo
//
//  Created by Ash Furrow on 2014-10-27.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

import UIKit
import ReactiveCocoa

class LoginViewController: UIViewController {
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let validEmailSignal = emailAddressTextField.rac_textSignal().map { (object) -> AnyObject! in
            let string = object as NSString
            let range: NSRange! = string.rangeOfString("@")
            return range.location != NSNotFound
        }
        
        let validPasswordSignal = passwordTextField.rac_textSignal().map { (object) -> AnyObject! in
            let string = object as String
            return countElements(string) > 6
        }
        
        RAC(goButton, "enabled") <~ RACSignal.combineLatest([validEmailSignal, validPasswordSignal]).and()
    }
}
