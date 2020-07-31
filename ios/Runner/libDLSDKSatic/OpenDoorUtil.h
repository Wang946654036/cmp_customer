//
//  OpenDoorUtil.h
//  DLSDKDemo
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const DLSDK_VERSION ;

typedef NS_ENUM(NSInteger, OpenDoorMode) {
    OpenDoorModeShakePhone      =  1,   //摇一摇
    OpenDoorModeClickImage      =  2,   //点击开门
    OpenDoorModeClickKey        =  3,   //点击指定钥匙
    OpenDoorModestartUp         =  4,   //启动开门
    OpenDoorModeBrightScreen    =  5,   //亮屏开门
};

/* 设备结果返回状态 */
typedef NS_ENUM(NSInteger, DLBleResultCode) {
    DLBLE_RESULT_BLUETOOTH_OFF,     /* 蓝牙未开 */
    DLBLE_RESULT_KEY_EMPTY,         /* 钥匙为空 */
    DLBLE_RESULT_TIMEOUT,           /* 连接超时 */
    DLBLE_RESULT_NO_DEVICE,         /* 未扫描到设备 */
    DLBLE_RESULT_WEAKSIGNAL,        /* 信号弱 */
    DLBLE_RESULT_MATCHKEY_ERROR,    /* 匹配钥匙失败 */
    DLBLE_RESULT_PASSWORD_ERROR,    /* 密码错误 */
    DLBLE_RESULT_OPENFINISH,        /* 开门成功 */
    DLBLE_RESULT_OPENFAIL,          /* 开门失败 */
};


@class OpenDoorUtil;
@protocol OpenDoorUtilDelegate <NSObject>


@required
/**
 *开门结束回调
 *@param result   开门状态返回码
 */
- (void)openDoorCompleteResultBack:(DLBleResultCode)result;

@end

@interface OpenDoorUtil : NSObject<DHBleDelegate,CBCentralManagerDelegate>

@property (weak, nonatomic) id <OpenDoorUtilDelegate> delegate;
/** 蓝牙开门管理器 */
@property(strong, nonatomic)DHBle    *sensor;

/** 蓝牙中心  */
@property(nonatomic,strong)CBCentralManager *centralManager;

/** 蓝牙开启状态 */
@property(nonatomic,assign)BOOL blueToothOpenState;

/** 开门方式 */
@property(nonatomic,assign)OpenDoorMode   openMode;

/** 当前开锁的设备ID */
@property(nonatomic,strong)NSString    *openPid;

/** 拥有权限的钥匙数组
 *  数组元素必须包含 @"pid" ,@"lock_id" 字段
 */
@property(nonatomic,strong)NSMutableArray    *keyInfoArray;

/** 扫描到的设备  */
@property(nonatomic,strong)NSMutableArray    *scanKeyInfoArray;

+(instancetype)shareManager;

/**
 *初始化
 */
-(void)bleInit;

/**
 * 一键开门
 *
 */
-(void)openDoor:(OpenDoorMode)openMode;

/**
 * 点击钥匙开门
 */
-(void)openDoorforKey:(NSDictionary *)keyInfo;



@end
