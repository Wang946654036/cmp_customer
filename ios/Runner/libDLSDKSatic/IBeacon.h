//
//  IBeacon.h
//  IBeacon
//
//  Created by Q on 2018/4/17.
//  Copyright © 2018年 Q. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kIBOpenErrorTypeOK,
    kIBOpenErrorTypeUnopenedLocation, //未开定位
    kIBOpenErrorTypeUnavailable,     //设备不支持
} IBOpenErrorType;

@interface IBeacon : NSObject
@property (copy, nonatomic) void (^brightScreenBlock)(void);

@property(nonatomic,assign,readonly) BOOL isAvailable;  ///<设备是否支持和区域权限请求


+ (IBeacon *)iBeacon;

/** 开启亮屏功能
 * completion  开启成功与否回调 (不成功存在可能： 设备不支持、永久定位未开启)
 */
- (void)openClient:(void(^__nullable)(BOOL success, IBOpenErrorType type))completion;
/** 关闭亮屏功能
 */
- (void)closeClient;
@end
