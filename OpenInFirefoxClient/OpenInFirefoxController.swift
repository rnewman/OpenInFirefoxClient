/* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class OpenInFirefoxController: NSObject {
    let firefoxScheme: NSString = "firefox:"
    let basicURL: NSURL = NSURL(string: "firefox://")!

    //input your custom URI scheme to provide callback to your app
    let myAppScheme: NSURL = NSURL(string: "firefoxopeninfirefoxclient://")!
    let app = UIApplication.sharedApplication()

    func isFirefoxInstalled() -> Bool {
        return app.canOpenURL(basicURL)
    }

    func openInFirefox(url: NSURL?) ->  Bool {
        return openInFirefox(url, callbackScheme: myAppScheme, createNewTab: false)
    }

    func openInFirefox(url: NSURL?, callbackScheme: NSURL?, createNewTab: Bool) -> Bool {
        if app.canOpenURL(basicURL) {
            if let url = url {
                var scheme: NSString = url.scheme!
                if scheme == "http" || scheme == "https" {
                    if let callback = callbackScheme {
                        var firefoxURLWithCallbackString: NSMutableString = NSMutableString(format: "%@//x-callback-url/open/?x-source=%@&url=%@", firefoxScheme, callback, url.absoluteString!)
                        let firefoxURL = NSURL(string: firefoxURLWithCallbackString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())! as String)
                        return app.openURL(firefoxURL!)
                    } else {
                        var firefoxURLString: NSMutableString = NSMutableString(format: "%@//open-url?url=%@", firefoxScheme, url.absoluteString!)
                        let firefoxURL = NSURL(string: firefoxURLString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())! as String)
                        return app.openURL(firefoxURL!)
                    }
                }
            }
        }
        return false
    }
}



