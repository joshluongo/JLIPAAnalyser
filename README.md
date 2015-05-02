# JLIPAAnalyser
A simple [IPA](https://en.wikipedia.org/wiki/.ipa_%28file_extension%29) metadata reader.

## Why?
I was tasked to create an Ad-Hoc [IPA](https://en.wikipedia.org/wiki/.ipa_%28file_extension%29) uploader. I needed the ability to get the Bundle Name, Bundle Identifer, Bundle Build & Bundle Version automatically.

## Install

#### With CocoaPods
_To be added!_

### Requirements
[__zipzap__](https://github.com/pixelglow/zipzap) - Used to get the Info.plist from the [IPA](https://en.wikipedia.org/wiki/.ipa_%28file_extension%29).

#### Without CocoaPods
Clone [__zipzap__](https://github.com/pixelglow/zipzap) into your project and add it to your target. Then clone this repository and add `JLIPAAnalyser.h` & `JLIPAAnalyser.m` to your project.

## Usage
Import the JLIPAAnalyser header
```objective-c
#import "JLIPAAnalyser.h"
```

__Get the Info.plist from an IPA.__
```objective-c
NSError *err = nil;

NSURL *fileURL = [NSURL fileURLWithPath:@"/Users/Josh/Desktop/HelloWorld.ipa"];

NSDictionary *info = [JLIPAAnalyser getInfoFromIpaWithURL:fileURL withError:&err];
```
__Get the Bundle Identifier from an IPA.__
```objective-c
NSError *err = nil;

NSURL *fileURL = [NSURL fileURLWithPath:@"/Users/Josh/Desktop/HelloWorld.ipa"];

JLAppInfo *info = [JLIPAAnalyser getAppInfoFromIpaWithURL:fileURL withError:&err];

NSString *appIdentifer = info.bundleIdentifer;
```

## License
JLIPAAnalyser is licensed under the [MIT License](https://tldrlegal.com/license/mit-license). 

This project makes use of [zipzap](https://github.com/pixelglow/zipzap) which is Licensed under the [BSD License](https://tldrlegal.com/license/bsd-3-clause-license-(revised)).
