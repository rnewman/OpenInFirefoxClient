#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

#import <UIKit/UIKit.h>
#import "OpenInFirefoxController.h"

static NSString * const firefoxScheme = @"firefox:";
static NSString * const myAppScheme = @"firefoxopeninfirefoxclient://";

@implementation OpenInFirefoxController

// Create a shared instance of the controller.
+ (OpenInFirefoxController *)sharedInstance {
  static OpenInFirefoxController *sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

// Check if Firefox is installed.
- (BOOL)isFirefoxInstalled {
  NSURL *url = [NSURL URLWithString:firefoxScheme];
  return  [[UIApplication sharedApplication] canOpenURL:url];
}

// Open a link in Firefox.
- (BOOL)openInFirefox:(NSURL *)url {
  NSURL *myAppSchemeURL = [NSURL URLWithString:myAppScheme];
  return [self openInFirefox:url callbackScheme:myAppSchemeURL createNewTab: NO];
}

- (BOOL)openInFirefox:(NSURL *)url
        callbackScheme:(NSURL *)myAppScheme
        createNewTab:(BOOL)createNewTab {

  NSURL *simpleFirefoxURL = [NSURL URLWithString:firefoxScheme];
  if (![[UIApplication sharedApplication] canOpenURL:simpleFirefoxURL]) {
    return NO;
  }

  NSString *scheme = [url.scheme lowercaseString];
  if (![scheme isEqualToString:@"http"] && ![scheme isEqualToString:@"https"]) {
    return NO;
  }

  if (myAppScheme) {
    NSString *urlString = [url absoluteString];
    NSMutableString *firefoxURLWithCallbackString = [NSMutableString string];
    [firefoxURLWithCallbackString appendFormat:@"%@//x-callback-url/open/?x-source=%@&url=%@",
                                  firefoxScheme, myAppScheme, urlString];
    NSString *escapedQuery = [firefoxURLWithCallbackString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *firefoxURL = [NSURL URLWithString:escapedQuery];

    // Open the URL with Firefox.
    return [[UIApplication sharedApplication] openURL:firefoxURL];
  }

  NSString *urlString = [url absoluteString];
  NSMutableString *firefoxURLString = [NSMutableString string];
  [firefoxURLString appendFormat:@"%@//open-url?url=%@", firefoxScheme, urlString];
  NSString *escapedQuery = [firefoxURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
  NSURL *firefoxURL = [NSURL URLWithString:escapedQuery];

  // Open the URL with Firefox.
  return [[UIApplication sharedApplication] openURL:firefoxURL];
}

@end
