//
//  File.swift
//  OpenInFirefoxClient
//
//  Created by Bryan Munar on 6/12/15.
//  Copyright (c) 2015 Bryan Munar. All rights reserved.
//

import Foundation
import UIKit

class OpenInFirefoxController: NSObject {
    let firefoxScheme: NSString = "firefox:"
    let basicURL: NSURL = NSURL(string: "firefox:")!
    let app = UIApplication.sharedApplication()

    //finished converting
    func isFirefoxInstalled() -> Bool {
        return app.canOpenURL(basicURL)
    }

    //finished converting(?)
    func openInFirefox(url: NSURL) ->  Bool {
        return openInFirefox(url, callbackURL: false, createNewTab: false)
    }

    func openInFirefox(url: NSURL, callbackURL: Bool, createNewTab: Bool) -> Bool {
        if app.canOpenURL(basicURL) {
            var scheme: NSString = url.scheme!
            if scheme == "http" || scheme == "https" {
                var firefoxURLString: NSMutableString = NSMutableString(format: "%@//open-url?url=%@", firefoxScheme, url.absoluteString!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
                let firefoxURL = NSURL(string: firefoxURLString as String)
                return app.openURL(firefoxURL!)
            }
        }
        return false
    }
}



