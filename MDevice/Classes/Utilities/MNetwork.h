
#import <Foundation/Foundation.h>

@interface MNetwork : NSObject

// Get Cell IP Address
+ (NSString *)cellIPAddress;

// Get WiFi IP Address
+ (NSString *)wiFiIPAddress;

// Connected to WiFi?
+ (BOOL)connectedToWiFi;

// Connected to Cellular Network?
+ (BOOL)connectedToCellNetwork;

@end
