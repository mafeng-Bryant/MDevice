#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MDevice.h"
#import "MDiskInfo.h"
#import "MLocalization.h"
#import "MMemoryInfo.h"
#import "MNetwork.h"

FOUNDATION_EXPORT double MDeviceVersionNumber;
FOUNDATION_EXPORT const unsigned char MDeviceVersionString[];

