#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "DLSDKHeader.h"
#import "ZSAlertView.h"
#import "LopeDoor.h"

@interface AppDelegate () <OpenDoorUtilDelegate,CBCentralManagerDelegate>

//主动打开蓝牙
@property(nonatomic,strong) CBCentralManager *bleManager;
@property(nonatomic,strong) FlutterMethodCall *lastBleMethodCall;
@property(nonatomic,strong) FlutterResult lastBleResult;

//开门回调
//@property(nonatomic,copy) FlutterResult openDoorResult;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    //Flutter 通道
    FlutterViewController *controller = (FlutterViewController *)self.window.rootViewController;
    FlutterMethodChannel *ZSWYChannel = [FlutterMethodChannel methodChannelWithName:@"zswy.flutter/channel" binaryMessenger:(NSObject<FlutterBinaryMessenger>*)controller];
    [ZSWYChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"openDoorInit"]) {
            [self nativeToOpenDoorInit];
        } else if ([call.method isEqualToString:@"openDoor"]) {
            [self nativeToOpenDoorWithMethodCall:call andResult:result];
        }else if ([call.method isEqualToString:@"openLopeDoorInit"]) {
            [[LopeDoor sharedInstance] initSDKWithMethodCall:call andResult:result];
        }else if ([call.method isEqualToString:@"openLopeDoor"]) {
            [[LopeDoor sharedInstance] openDoorWithMethodCall:call andResult:result];
        } else {
            
        }
    }];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

//一键开门处理
- (void)nativeToOpenDoorInit {
//    //得令开门SDK初始化
//    [[OpenDoorUtil shareManager] bleInit];
//    [OpenDoorUtil shareManager].delegate = self;
}

- (void)nativeToOpenDoorWithMethodCall:(FlutterMethodCall *)call andResult:(FlutterResult) result {
    self.lastBleMethodCall = call;
    self.lastBleResult = result;
    if (![OpenDoorUtil shareManager].centralManager) {       //20200103 - 修改为开门时再初始化
        [self openSysBle];
    } else {
        [self openDoorImplWithMethodCall:call andResult:result];
    }
}

//实际蓝牙开门操作
- (void)openDoorImplWithMethodCall:(FlutterMethodCall *)call andResult:(FlutterResult) result {
    //开门
    id openDoorParams = call.arguments;
    if (openDoorParams && [openDoorParams isKindOfClass:[NSDictionary class]]) {
        NSString *pid = @"";
        NSString *lockId = @"";
        pid = openDoorParams[@"pid"];
        lockId = openDoorParams[@"lockId"];
        
        [[OpenDoorUtil shareManager]openDoorforKey:@{@"pid" : pid, @"lock_id" : lockId}];
    }
}

//打开系统蓝牙
- (void)openSysBle {
    [[OpenDoorUtil shareManager] bleInit];
    [OpenDoorUtil shareManager].delegate = self;
    self.bleManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state == CBManagerStatePoweredOn) {
        //得令开门SDK初始化
        //        [OpenDoorUtil shareManager].blueToothOpenState = YES;
        //        [NSThread sleepForTimeInterval:1];      //等待初始化完成
        [self openDoorImplWithMethodCall:self.lastBleMethodCall andResult:self.lastBleResult];
    } else {
        NSDictionary *resultDict = @{@"code" : @"1", @"message" : @"请打开蓝牙"};
        if (self.lastBleResult) {
            self.lastBleResult(resultDict);
            self.lastBleResult = nil;
        }
    }
}

- (BOOL)isCanOpen:(NSString *)appSchemeStr {
    if ([appSchemeStr isEqualToString:@""] || appSchemeStr == nil) {
        return NO;
    }
    NSURL *appSchemeURL = [NSURL URLWithString:appSchemeStr];
    BOOL canOpen = [[UIApplication sharedApplication]canOpenURL:appSchemeURL];
    return canOpen;
}

- (void)openAppWithScheme:(NSString *)appSchemeStr {
    if ([appSchemeStr isEqualToString:@""] || appSchemeStr == nil) {
        return;
    }
    
    NSURL *appSchemeURL = [NSURL URLWithString:appSchemeStr];
    if ([self isCanOpen:appSchemeStr]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:appSchemeURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : [NSNumber numberWithBool:NO]} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:appSchemeURL];
        }
    } else {
        [[ZSAlertView sharedInstance] showAlertController:self.window.rootViewController title:@"未检测到招商置业，请安装后重试" message:nil cancelTitle:@"好" actionBlock:nil otherButtonTitles:nil];
    }
}

#pragma mark --OpenDoorUtilDelegate--
- (void)openDoorCompleteResultBack:(DLBleResultCode)result {
    NSString *tipStr = @"开门失败";
    NSString *resultCode = @"1";
    //        DLBLE_RESULT_BLUETOOTH_OFF,     /* 蓝牙未开 */
    //        DLBLE_RESULT_KEY_EMPTY,         /* 钥匙为空 */
    //        DLBLE_RESULT_TIMEOUT,           /* 连接超时 */
    //        DLBLE_RESULT_NO_DEVICE,         /* 未扫描到设备 */
    //        DLBLE_RESULT_WEAKSIGNAL,        /* 信号弱 */
    //        DLBLE_RESULT_MATCHKEY_ERROR,    /* 匹配钥匙失败 */
    //        DLBLE_RESULT_PASSWORD_ERROR,    /* 密码错误 */
    //        DLBLE_RESULT_OPENFINISH,        /* 开门成功 */
    //        DLBLE_RESULT_OPENFAIL,          /* 开门失败 */
    if (result == DLBLE_RESULT_OPENFINISH) {
        tipStr = @"开门成功";
        resultCode = @"0";
    } else {
        resultCode = @"1";
        switch (result) {
            case DLBLE_RESULT_BLUETOOTH_OFF:
                tipStr = @"蓝牙未开";
                break;
            case DLBLE_RESULT_KEY_EMPTY:
                tipStr = @"钥匙为空";
                break;
            case DLBLE_RESULT_TIMEOUT:
                tipStr = @"连接超时";
                break;
            case DLBLE_RESULT_NO_DEVICE:
                tipStr = @"未扫描到设备";
                break;
            case DLBLE_RESULT_WEAKSIGNAL:
                tipStr = @"信号弱";
                break;
            case DLBLE_RESULT_MATCHKEY_ERROR:
                tipStr = @"匹配钥匙失败";
                break;
            case DLBLE_RESULT_PASSWORD_ERROR:
                tipStr = @"密码错误";
                break;
            case DLBLE_RESULT_OPENFAIL:
                tipStr = @"开门失败";
                break;
            default:
                break;
        }
        
    }
    
    if (self.lastBleResult) {
        NSDictionary *reslut = @{@"code" : resultCode, @"message" : tipStr};
        self.lastBleResult(reslut);
        self.lastBleResult = nil;
    }
    
    //    [[ZSAlertView sharedInstance] showAlertController:self.window.rootViewController title:tipStr message:nil cancelTitle:@"好" actionBlock:nil otherButtonTitles:nil];
}

@end
