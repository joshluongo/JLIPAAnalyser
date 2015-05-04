//
//  JLIPAAnalyser.m
//  JLIPAAnalyser - Version 1.0.1
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

#import "JLIPAAnalyser.h"
#import <zipzap/zipzap.h>

@implementation JLAppInfo

- (NSString *)description
{
    return [NSString stringWithFormat:@"Source: %@\nBundle Name: %@\nBundle Identifer: %@\nBundle Short Version: %@\nBundle Build: %@", self.url.absoluteString, self.bundleName, self.bundleIdentifer, self.bundleShortVersion, self.bundleBuild];
}

@end

@implementation JLIPAAnalyser

+ (NSDictionary *)getInfoFromIpaWithURL:(NSURL *)url withError:(NSError **)error
{
    if (![[url.pathExtension lowercaseString] isEqualToString:@"ipa"])
    {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"Error: File must end with .ipa" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"JLIPAAnalyser" code:403 userInfo:details];
        return nil;
    }
    
    NSError *err;
    
    ZZArchive *appArchive = [ZZArchive archiveWithURL:url
                                                error:&err];
    if (err)
    {
        *error = err;
        return nil;
    }
    
    ZZArchiveEntry *infoPlistArchive = [self findInfoPlistWithList:appArchive.entries withError:&err];
    
    if (err)
    {
        *error = err;
        return nil;
    }
    
    NSData *infoPlistData = [infoPlistArchive newDataWithError:&err];
    if (err)
    {
        *error = err;
        return nil;
    }
    
    NSDictionary *infoPlist = [NSPropertyListSerialization propertyListWithData:infoPlistData options:NSPropertyListImmutable format:NULL error:&err];
    if (err)
    {
        *error = err;
        return nil;
    }
    
    return infoPlist;
}

+ (JLAppInfo *)getAppInfoFromIpaWithURL:(NSURL *)url withError:(NSError **)error
{
    NSError *err;
    
    NSDictionary *infoPlist = [self getInfoFromIpaWithURL:url withError:&err];
    
    if (err)
    {
        *error = err;
        return nil;
    }

    JLAppInfo *info = [JLAppInfo new];
    
    info.bundleName = infoPlist[@"CFBundleName"];
    info.bundleDisplayName = infoPlist[@"CFBundleDisplayName"];
    info.bundleIdentifer = infoPlist[@"CFBundleIdentifier"];
    info.bundleShortVersion = infoPlist[@"CFBundleShortVersionString"];
    info.bundleBuild = infoPlist[@"CFBundleVersion"];
    
    info.url = url;
    info.infoPlist = infoPlist;
    
    return info;
}

+ (ZZArchiveEntry *)findInfoPlistWithList:(NSArray *)list withError:(NSError **)error
{
    for (ZZArchiveEntry *info in list) {
        if ([[info.fileName lowercaseString] rangeOfString:@".app/info.plist"].location != NSNotFound)
        {
            return info;
        }
    }
    
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:@"Error: Did'nt find a Info.plist in the IPA." forKey:NSLocalizedDescriptionKey];
    *error = [NSError errorWithDomain:@"JLIPAAnalyser" code:404 userInfo:details];
    
    return nil;
}

@end