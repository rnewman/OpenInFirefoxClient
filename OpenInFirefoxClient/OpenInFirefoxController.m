//#if !defined(__has_feature) || !__has_feature(objc_arc)
//#error "This file requires ARC support."
//#endif
///* This Source Code Form is subject to the terms of the Mozilla Public
// * License, v. 2.0. If a copy of the MPL was not distributed with this
// * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
//#import <UIKit/UIKit.h>
//#import "OpenInFirefoxController.h"
//
//static NSString * const firefoxScheme = @"firefox:";
//
//@implementation OpenInFirefoxController
//
////creates shared instance of the controller
//+ (OpenInFirefoxController *)sharedInstance {
//  static OpenInFirefoxController *sharedInstance;
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    sharedInstance = [[self alloc] init];
//  });
//  return sharedInstance;
//}
//
////checks if firefox is installed
//- (BOOL)isFirefoxInstalled {
//  NSURL *url = [NSURL URLWithString:firefoxScheme];
//    return  [[UIApplication sharedApplication] canOpenURL:url];
//}
//
//
////- (BOOL)openInChrome:(NSURL *)url
////     withCallbackURL:(NSURL *)callbackURL
////        createNewTab:(BOOL)createNewTab {
////    NSURL *chromeSimpleURL = [NSURL URLWithString:kGoogleChromeHTTPScheme];
////    NSURL *chromeCallbackURL = [NSURL URLWithString:kGoogleChromeCallbackScheme];
////    if ([[UIApplication sharedApplication] canOpenURL:chromeCallbackURL]) {
////        NSString *appName =
////        [[NSBundle mainBundle]
////         objectForInfoDictionaryKey:@"CFBundleDisplayName"];
////
////        NSString *scheme = [url.scheme lowercaseString];
////
////        // Proceed only if scheme is http or https.
////        if ([scheme isEqualToString:@"http"] ||
////            [scheme isEqualToString:@"https"]) {
////
////            NSMutableString *chromeURLString = [NSMutableString string];
////            [chromeURLString appendFormat:
////             @"%@//x-callback-url/open/?x-source=%@&url=%@",
////             kGoogleChromeCallbackScheme,
////             encodeByAddingPercentEscapes(appName),
////             encodeByAddingPercentEscapes([url absoluteString])];
////            if (callbackURL) {
////                [chromeURLString appendFormat:@"&x-success=%@",
////                 encodeByAddingPercentEscapes([callbackURL absoluteString])];
////            }
////            if (createNewTab) {
////                [chromeURLString appendString:@"&create-new-tab"];
////            }
////
////            NSURL *chromeURL = [NSURL URLWithString:chromeURLString];
////            
////            // Open the URL with Google Chrome.
////            return [[UIApplication sharedApplication] openURL:chromeURL];
////        }
////    }
//
////function to actually open the link in firefox
//- (BOOL)openInFirefox:(NSURL *)url {
//  NSURL *simpleFirefoxURL = [NSURL URLWithString:firefoxScheme];
//    if ([[UIApplication sharedApplication] canOpenURL:simpleFirefoxURL]) {
//      NSString *scheme = [url.scheme lowercaseString];
//      if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
//        NSString *urlString = [url absoluteString];
//        NSMutableString *firefoxURLString = [NSMutableString string];
//        [firefoxURLString appendFormat:@"%@//open-url?url=%@", firefoxScheme, urlString];
//        NSString * escapedQuery = [firefoxURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        NSURL *firefoxURL = [NSURL URLWithString:escapedQuery];
//
//        // Open the URL with Firefox.
//        return [[UIApplication sharedApplication] openURL:firefoxURL];
//      }
//    }
//  return NO;
//}
//
//@end
