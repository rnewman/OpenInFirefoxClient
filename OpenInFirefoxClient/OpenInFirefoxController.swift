/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

public class OpenInFirefoxController {
    private let firefoxScheme = "firefox:"
    private let basicURL = NSURL(string: "firefox://")!

    // CUSTOMIZE THIS:
    // Define your custom URI scheme to provide callback to your app.
    let myAppScheme: NSURL = NSURL(string: "firefoxopeninfirefoxclient://")!
    let app = UIApplication.sharedApplication()

    public func isFirefoxInstalled() -> Bool {
        return app.canOpenURL(basicURL)
    }

    public func openInFirefox(url: NSURL?) ->  Bool {
        return openInFirefox(url, callbackScheme: myAppScheme, createNewTab: false)
    }

    public func openInFirefox(url: NSURL?, createNewTab: Bool) ->  Bool {
        return openInFirefox(url, callbackScheme: nil, createNewTab: createNewTab)
    }

    public func openInFirefox(url: NSURL?, callbackScheme: NSURL?, createNewTab: Bool) -> Bool {
        if !app.canOpenURL(basicURL) {
            return false
        }

        if let url = url, scheme = url.scheme where scheme == "https" || scheme == "http" {
            let allowed = NSCharacterSet.URLQueryAllowedCharacterSet()
            if let callback = callbackScheme {
                let withCallback = NSString(format: "%@//x-callback-url/open/?x-source=%@&url=%@", firefoxScheme, callback, url.absoluteString!)
                if let url = self.encode(withCallback) {
                    return app.openURL(url)
                }
                return false
            }

            let openString = NSString(format: "%@//open-url?url=%@", firefoxScheme, url.absoluteString!)
            if let url = self.encode(openString) {
                return app.openURL(url)
            }
            return false
        }

        return false
    }

    private func encode(string: NSString) -> NSURL? {
        let allowed = NSCharacterSet.URLQueryAllowedCharacterSet()

        if let encoded = string.stringByAddingPercentEncodingWithAllowedCharacters(allowed) {
            return NSURL(string: encoded as String)
        }

        return nil
    }
}



