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
    let myAppScheme: NSURL = NSURL(string: "firefoxopeninfirefoxclient://")!
    let app = UIApplication.sharedApplication()

    //finished converting
    func isFirefoxInstalled() -> Bool {
        return app.canOpenURL(basicURL)
    }

    //finished converting(?)
    func openInFirefox(url: NSURL) ->  Bool {
        return openInFirefox(url, callbackScheme: myAppScheme, createNewTab: false)
    }

    //- (BOOL)openInChrome:(NSURL *)url
    //     withCallbackURL:(NSURL *)callbackURL
    //        createNewTab:(BOOL)createNewTab {
    //    NSURL *chromeSimpleURL = [NSURL URLWithString:kGoogleChromeHTTPScheme];
    //    NSURL *chromeCallbackURL = [NSURL URLWithString:kGoogleChromeCallbackScheme];
    //    if ([[UIApplication sharedApplication] canOpenURL:chromeCallbackURL]) {
    //        NSString *appName =
    //        [[NSBundle mainBundle]
    //         objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    //
    //        NSString *scheme = [url.scheme lowercaseString];
    //
    //        // Proceed only if scheme is http or https.
    //        if ([scheme isEqualToString:@"http"] ||
    //            [scheme isEqualToString:@"https"]) {
    //
    //            NSMutableString *chromeURLString = [NSMutableString string];
    //            [chromeURLString appendFormat:
    //             @"%@//x-callback-url/open/?x-source=%@&url=%@",
    //             kGoogleChromeCallbackScheme,
    //             encodeByAddingPercentEscapes(appName),
    //             encodeByAddingPercentEscapes([url absoluteString])];
    //            if (callbackURL) {
    //                [chromeURLString appendFormat:@"&x-success=%@",
    //                 encodeByAddingPercentEscapes([callbackURL absoluteString])];
    //            }
    //            if (createNewTab) {
    //                [chromeURLString appendString:@"&create-new-tab"];
    //            }
    //
    //            NSURL *chromeURL = [NSURL URLWithString:chromeURLString];
    //
    //            // Open the URL with Google Chrome.
    //            return [[UIApplication sharedApplication] openURL:chromeURL];
    //        }
    //    }

    func openInFirefox(url: NSURL, callbackScheme: NSURL?, createNewTab: Bool) -> Bool {
        if app.canOpenURL(basicURL) {
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
        return false
    }

}



