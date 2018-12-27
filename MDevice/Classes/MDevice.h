//
//  MDevice.h
//  MDevice_Example
//
//  Created by patpat on 2018/10/19.
//  Copyright © 2018年 1499603656@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDiskInfo.h"
#import "MMemoryInfo.h"
#import "MLocalization.h"
#import "MNetwork.h"
#import "MFStoreHelper.h"

@interface MDevice : NSObject

/**
 * 获取设备详细信息
 */
+ (NSString *)infos;

/**
 * 获取系统名称
 */
+ (NSString *)systemName;

/**
 * 获取设备类型
 */
+ (NSString *)deviceType;

/**
 * 获取设备model
 */
+ (NSString *)deviceModel;

/**
 * 获取系统版本
 */
+ (NSString *)systemVersion;

/**
 * 获取屏幕尺寸
 */
+ (NSString *)screenSize;

/**
 * 获取国家
 */
+ (NSString *)country;

/**
 * 获取Currency Symbol
 */
+ (NSString *)currency;

/**
 * 获取系统语言
 */
+ (NSString *)language;

/**
 * 获取timezone
 */
+ (NSString *)timeZone;

/**
 *  设备信息
 */
+ (NSDictionary *)deviceInfo;

/**
 *  设备UUID
 *
 *  @return NSString
 */
+ (NSString *)deviceUUID;


/**
 *  获取所有国家信息
 *
 *  @return NSDictionary
 */
+ (NSDictionary*)getDeviceCountryInfo;


@end

