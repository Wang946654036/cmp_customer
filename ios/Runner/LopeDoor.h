//
//  LopeDoor.h
//  Runner
//
//  Created by William on 2020/4/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LopeKit/LopeKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface LopeDoor : NSObject


+ (LopeDoor *)sharedInstance;

- (void)initSDKWithMethodCall:(FlutterMethodCall *)call andResult:(FlutterResult)result;
- (void)openDoorWithMethodCall:(FlutterMethodCall *)call andResult:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
