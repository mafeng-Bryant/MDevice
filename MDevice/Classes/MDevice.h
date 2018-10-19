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

@interface MDevice : NSObject

+ (NSString *)infos;

+ (NSString *)systemName;

+ (NSString *)deviceType;

+ (NSString *)deviceModel;

+ (NSString *)systemVersion;

+ (NSString *)screenSize;

+ (NSString *)country;

+ (NSString *)currency;

+ (NSString *)language;

+ (NSString *)timeZone;


@end

