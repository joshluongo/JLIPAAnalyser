//
//  JLIPAAnalyser.h
//  JLIPAAnalyser - Version 1.0
//
//  Created by Joshua Luongo on 1/05/2015.
//  Copyright (c) 2015 Josh Luongo (JR Apps). All rights reserved.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Josh Luongo
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

@import Foundation;

@interface JLAppInfo : NSObject

/**
 The URL of the File that has been analysed.
*/
@property (nonatomic, copy) NSURL *url;

/**
 The short name of the IPA.
 */
@property (nonatomic, copy) NSString *bundleName;

/**
 The bundle identifer of the IPA.
 */
@property (nonatomic, copy) NSString *bundleIdentifer;

/**
 The short version of the IPA.
 */
@property (nonatomic, copy) NSString *bundleShortVersion;

/**
 The build of the IPA.
 */
@property (nonatomic, copy) NSString *bundleBuild;

/**
 A @b Info.plist @@b of the IPA.
 */
@property (nonatomic, copy) NSDictionary *infoPlist;

@end

@interface JLIPAAnalyser : NSObject

/**
 Use this method to get @b Info.plist @@b Dictionary from an IPA file.

 @param  url This is the URL of the IPA to analyse.
 @param  error This will contain the NSError of what went wrong.
 @return If this is set to nil then something went wrong, If all went well then this will return the Info.plist of the IPA.
 */
+ (NSDictionary *)getInfoFromIpaWithURL:(NSURL *)url withError:(NSError **)error;

/**
 Use this method to get Basic Metadata from an IPA file.
 
 @param  url This is the URL of the IPA to analyse.
 @param  error This will contain the NSError of what went wrong.
 @return If this is set to nil then something went wrong, If all went well then this will return a `JLAppInfo` of the basic metadata from an IPA.
 */
+ (JLAppInfo *)getAppInfoFromIpaWithURL:(NSURL *)url withError:(NSError **)error;

@end

