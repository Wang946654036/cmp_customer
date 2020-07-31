//
//  LopeDoor.m
//  Runner
//
//  Created by William on 2020/4/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "LopeDoor.h"

#define PID          @"0oki87uyhnj76545tgls987"

@interface LopeDoor () <NPDSophKeyDelegate, CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager        *centralManager;
@property (nonatomic, strong) FlutterMethodCall       *lastBleMethodCall;
@property (nonatomic, strong) FlutterResult           lastBleResult;
@property (nonatomic, strong) FlutterResult           initSDKResult;
@property (nonatomic, strong) NPDSophKey              *key;
@property (nonatomic, assign) BOOL                    hasConfigSuccess;
@property (nonatomic, strong) NSArray                 *locks;
@property (nonatomic, assign) BOOL                    busy;

@end

@implementation LopeDoor

+ (LopeDoor *)sharedInstance {
    static LopeDoor *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)initSDKWithMethodCall:(FlutterMethodCall *)call andResult:(FlutterResult)result {
    self.initSDKResult = result;
    [self configSDK];
}

- (void)openDoorWithMethodCall:(FlutterMethodCall *)call andResult:(FlutterResult)result {
    self.lastBleMethodCall = call;
    self.lastBleResult = result;
    
    id openDoorParams = call.arguments;
    if (!openDoorParams || ![openDoorParams isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *mac = openDoorParams[@"mac"];
    NSString *pkey = openDoorParams[@"key"];

    if(!mac || !pkey) {
        NSLog(@"参数错误：mac: %@, key: %@", mac, pkey);
        [self resultWithCode:@"1" message:@"mac、key不能为空"];
        return;
    }
    
    self.locks = @[@{@"mac":mac, @"key": pkey}];

    if(self.hasConfigSuccess) {
        [self openDoorRef];
    }else {
        [self configSDK];
    }
}

- (void)configSDK {
    [NPDSophKey enableLog:YES];
    NPDSophKey *key = [NPDSophKey sharedSophKey];
    [key configureWithPid:PID delegate:self];
    self.key = key;
}

- (void)openDoorRef {
    if(self.centralManager) {
        [self openDoor];
    }else {
        [self openSysBle];
    }
}

- (void)openSysBle {
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)openDoor {
    if (!self.busy) {
        self.busy = YES;
        [self.key startScanWithInterval:0.3 serviceUUIDs:@[@"2560",@"FEE7"] immediately:NO];
    } else {
        NSLog(@"正在执行,请稍后..");
    }
}

- (BOOL)testOpenIfOk:(NSDictionary *)device {
    if (device && [device[K_TYPE] isEqual:@1]) {
        for (NSDictionary *myDev in self.locks) {
            if ([myDev[@"mac"] isEqualToString:device[K_MAC]]) {
                [self.key openDoorWithKey:myDev[@"key"] fwVersion:[device[K_FW_VERSION] shortValue]
                               peripheral:device[K_PERIPHERAL]
                           centralManager:nil
                                 deviceId:[device[K_DEVICE_ID] unsignedIntegerValue]];
                return YES;
            }
        }
    }
    return NO;
}

- (void)stopBleScan {
    [self.centralManager stopScan];
}

- (void)resultWithCode:(NSString *)code message:(NSString *)message {
    NSDictionary *resultDict = @{@"code" : code, @"message" : message};
    if (self.lastBleResult) {
        self.lastBleResult(resultDict);
        self.lastBleResult = nil;
    }
}

#pragma mark - NPDSophKeyDelegate
- (void)initResult:(BOOL)success errorCode:(NPDErrorCode)code {
    if (success) {
        NSLog(@"Init success");
        self.hasConfigSuccess = YES;
        if(self.initSDKResult) {
            NSDictionary *resultDict = @{@"code" : @"0", @"message" : @"初始化成功"};
            self.initSDKResult(resultDict);
            self.initSDKResult = nil;
        }else {
            [self openDoorRef];
        }
    } else {
        NSLog(@"Init failed, code:%@", @(code));
        if(self.initSDKResult) {
            NSDictionary *resultDict = @{@"code" : @"1", @"message" : @"初始化失败"};
            self.initSDKResult(resultDict);
            self.initSDKResult = nil;
        }
    }
}

- (void)openDoorResult:(BOOL)success errorCode:(NPDErrorCode)code extInfo:(NSDictionary *)info {
    NSLog(@"Open door result %@. extInfo:%@, code: %li", success ? @"success" : @"failed", info, (long)code);
    self.busy = NO;
    if(success) {
        [self resultWithCode:@"0" message:@"开门成功"];
    }else {
        NSString *msg = @"";
        switch (code) {
            case NPDOpenDoorFailed:
                msg = @"开门失败";
                break;
            case NPDOpenDoorKeyError:
                msg = @"密钥错误";
                break;
            case NPDOpenDoorNoAuthority:
                msg = @"无授权";
                break;
            case NPDOpenDoorGetInfoFailed:
                msg = @"获取门禁信息失败";
                break;
            case NPDOpenDoorTimeout:
                msg = @"开门超时";
                break;
            case NPDOpenDoorKeyFormattingIllegal:
                msg = @"密钥格式不合法";
                break;
            default:
                msg = @"开门失败";
                break;
        }
        [self resultWithCode:@"1" message:msg];
    }
}

- (void)scanResult:(BOOL)success errorCode:(NPDErrorCode)code extInfo:(NSArray *)infos {
    if (success) {
        NSLog(@"Scan success.infos:%@", infos);
        if (infos && [infos count] > 0) {
            for (NSDictionary *item in infos) {
                if ([self testOpenIfOk:item]) {
                    return;
                }
            }
        }
    } else {
        NSLog(@"Scan failed code:%@", @(code));
        [self resultWithCode:@"1" message:@"未发现蓝牙设备"];
    }
    self.busy = NO;
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn) {
        NSLog(@"蓝牙已经打开");
        [self openDoor];
    } else if (central.state == CBManagerStateUnauthorized)  {
        self.centralManager = nil;
        [self resultWithCode:@"1" message:@"请打开蓝牙权限"];
    }else {
        self.centralManager = nil;
        [self resultWithCode:@"1" message:@"请打开蓝牙"];
    }
}

@end
