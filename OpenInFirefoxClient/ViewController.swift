//
//  ViewController.swift
//  OpenInFirefoxClient
//
//  Created by Bryan Munar on 6/12/15.
//  Copyright (c) 2015 Bryan Munar. All rights reserved.
//

import Foundation
import UIKit
import WebKit
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myWebView:UIWebView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))

        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.yellowColor()
        button.setTitle("Test Button", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)

        self.view.addSubview(myWebView)
        self.view.addSubview(button)
    }

    func buttonAction(sender: UIButton!) {
        if let url = NSURL(string: "http://www.mozilla.com") {
            var controller = OpenInFirefoxController()
            if controller.isFirefoxInstalled() {
                controller.openInFirefox(url)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

