//
//  MDevice.m
//  MDevice_Example
//
//  Created by patpat on 2018/10/19.
//  Copyright © 2018年 1499603656@qq.com. All rights reserved.
//

#import "MDevice.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation MDevice

+ (NSString *)infos
{
    //启动时间
    NSArray *uptimeFormat = [[MDevice systemUptime] componentsSeparatedByString:@" "];
    NSString *systemUptime = [NSString stringWithFormat:@"System Uptime: %@ Days %@ Hours %@ Minutes", [uptimeFormat objectAtIndex:0], [uptimeFormat objectAtIndex:1], [uptimeFormat objectAtIndex:2]];
    NSString *deviceModel = [NSString stringWithFormat:@"Device Model: %@", [MDevice deviceModel]];
    NSString *deviceName = [NSString stringWithFormat:@"Device Name: %@", [MDevice deviceName]];
    NSString *systemName = [NSString stringWithFormat:@"System Name: %@", [MDevice systemName]];
    NSString *systemVersion = [NSString stringWithFormat:@"System Version: %@", [MDevice systemVersion]];
    NSString *systemDeviceTypeFormattedNO = [NSString stringWithFormat:@"System Device Type Unformatted: %@", [MDevice systemDeviceTypeFormatted:NO]];
    NSString *systemDeviceTypeFormattedYES = [NSString stringWithFormat:@"System Device Type Formatted: %@", [MDevice systemDeviceTypeFormatted:YES]];
    NSString *screenWidth = [NSString stringWithFormat:@"Screen Width: %ld Pixels", (long)[MDevice screenWidth]];
    NSString *screenHeight = [NSString stringWithFormat:@"Screen Height: %ld Pixels", (long)[MDevice screenHeight]];
    NSString *screenBrightness = [NSString stringWithFormat:@"Screen Brightness: %.0f%%", [MDevice screenBrightness]];
    NSString *multitaskingEnabled = ([MDevice multitaskingEnabled]) ? @"Multitasking Enabled: Yes" : @"Multitasking: No";
    NSString *charging = ([MDevice charging]) ? @"Charging: Yes" : @"Charging: No";
    NSString *fullyCharged = ([MDevice fullyCharged]) ? @"Fully Charged: Yes" : @"Fully Charged: No";
    NSString *country = [NSString stringWithFormat:@"Country: %@", [MLocalization country]];
    NSString *language = [NSString stringWithFormat:@"Language: %@", [MLocalization language]];
    NSString *timeZone = [NSString stringWithFormat:@"TimeZone: %@", [MLocalization timeZone]];
    NSString *currency = [NSString stringWithFormat:@"Currency: %@", [MLocalization currency]];
    NSString *applicationVersion = [NSString stringWithFormat:@"Application Version: %@ ,build Version: %@", [MDevice applicationVersion],[MDevice buildVersion]];
    NSString *clipboardContent = [NSString stringWithFormat:@"ClipBoard Content: \"%@\"", [MDevice clipboardContent]];
    NSString *carrierName = [NSString stringWithFormat:@"Carrier Name: %@",[MDevice carrierName]];
    NSString *carrierCountry = [NSString stringWithFormat:@"Carrier Country: %@",[MDevice carrierCountry]];
    NSString *cellIPAddress = [NSString stringWithFormat:@"Cell IP Address: %@",[MNetwork cellIPAddress]];
    NSString *wiFiIPAddress = [NSString stringWithFormat:@"WiFi IP Address: %@",[MNetwork wiFiIPAddress]];
    NSString *connectedToWiFi = ([MNetwork connectedToWiFi]) ? @"Connected to WiFi: Yes" : @"Connected to WiFi: No";
    NSString *connectedToCellNetwork = ([MNetwork connectedToCellNetwork]) ? @"Connected to Cell Network: Yes" : @"Connected to Cell Network: No";
    NSString *totalMemory = [NSString stringWithFormat:@"Memory (RAM): (±)%.2f MB",[MMemoryInfo totalMemory]];
    // Used Memory
    NSString *usedMemory = [NSString stringWithFormat:@"Used Memory: %.2f MB \t%.0f%%", [MMemoryInfo usedMemory:NO], [MMemoryInfo usedMemory:YES]];
    NSString *wiredMemory = [NSString stringWithFormat:@"Wired Memory: %.2f MB \t%.0f%%", [MMemoryInfo wiredMemory:NO], [MMemoryInfo wiredMemory:YES]];// Wired Memory
    NSString *activeMemory = [NSString stringWithFormat:@"Active Memory: %.2f MB \t%.0f%%", [MMemoryInfo activeMemory:NO], [MMemoryInfo activeMemory:YES]];// Active Memory
    NSString *inactiveMemory = [NSString stringWithFormat:@"Inactive Memory: %.2f MB \t%.0f%%", [MMemoryInfo inactiveMemory:NO], [MMemoryInfo inactiveMemory:YES]];// Inactive Memory
    NSString *freeMemory = [NSString stringWithFormat:@"Free Memory: %.2f MB \t%.0f%%", [MMemoryInfo freeMemory:NO], [MMemoryInfo freeMemory:YES]]; // Free Memory
    NSString *purgableMemory = [NSString stringWithFormat:@"Purgeable Memory: %.2f MB \t%.0f%%", [MMemoryInfo purgableMemory:NO], [MMemoryInfo purgableMemory:YES]];// Purgeable Memory
    NSArray *infoArrays = [NSArray arrayWithObjects:systemUptime,deviceModel,deviceName,
                           systemName,systemVersion,systemDeviceTypeFormattedNO,
                           systemDeviceTypeFormattedYES,screenWidth,
                           screenHeight,screenBrightness,multitaskingEnabled,charging,fullyCharged,
                           country,language,timeZone,
                           currency,applicationVersion,clipboardContent,
                           carrierName,carrierCountry,cellIPAddress,
                           wiFiIPAddress,connectedToWiFi,connectedToCellNetwork,
                           totalMemory,usedMemory,wiredMemory,
                           activeMemory,inactiveMemory,freeMemory,purgableMemory,nil];
    NSString *infos = [infoArrays componentsJoinedByString:@"\n"];
    return infos;
}

+ (NSString *)country
{
    return [MLocalization country];
}

+ (NSString *)currency
{
    return [MLocalization currency];
}


+ (NSString *)language
{
    return [MLocalization language];
}

+ (NSString *)timeZone
{
    return [MLocalization timeZone];
}

+ (NSString *)deviceType
{
    return [MDevice systemDeviceTypeFormatted:NO];
}

+ (NSString *)screenSize
{
    return [NSString stringWithFormat:@"%ld:%d", (long)[MDevice screenWidth], [MDevice screenHeight]];
}

// System Hardware Information

// System Uptime (dd hh mm)
+ (NSString *)systemUptime {
    // Set up the days/hours/minutes
    NSNumber *Days, *Hours, *Minutes;
    
    // Get the info about a process
    NSProcessInfo * processInfo = [NSProcessInfo processInfo];
    // Get the uptime of the system
    NSTimeInterval UptimeInterval = [processInfo systemUptime];
    // Get the calendar
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    // Create the Dates
    NSDate *Date = [[NSDate alloc] initWithTimeIntervalSinceNow:(0-UptimeInterval)];
    unsigned int unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *Components = [Calendar components:unitFlags fromDate:Date toDate:[NSDate date]  options:0];
    
    // Get the day, hour and minutes
    Days = [NSNumber numberWithInt:[Components day]];
    Hours = [NSNumber numberWithInt:[Components hour]];
    Minutes = [NSNumber numberWithInt:[Components minute]];
    
    // Format the dates
    NSString *Uptime = [NSString stringWithFormat:@"%@ %@ %@",
                        [Days stringValue],
                        [Hours stringValue],
                        [Minutes stringValue]];
    
    // Error checking
    if (!Uptime) {
        // No uptime found
        // Return nil
        return nil;
    }
    
    // Return the uptime
    return Uptime;
}

// Model of Device
+ (NSString *)deviceModel {
    // Get the device model
    if ([[UIDevice currentDevice] respondsToSelector:@selector(model)]) {
        // Make a string for the device model
        NSString *deviceModel = [[UIDevice currentDevice] model];
        // Set the output to the device model
        return deviceModel;
    } else {
        // Device model not found
        return nil;
    }
}

// Device Name
+ (NSString *)deviceName {
    // Get the current device name
    if ([[UIDevice currentDevice] respondsToSelector:@selector(name)]) {
        // Make a string for the device name
        NSString *deviceName = [[UIDevice currentDevice] name];
        // Set the output to the device name
        return deviceName;
    } else {
        // Device name not found
        return nil;
    }
}

// System Name
+ (NSString *)systemName {
    // Get the current system name
    if ([[UIDevice currentDevice] respondsToSelector:@selector(systemName)]) {
        // Make a string for the system name
        NSString *systemName = [[UIDevice currentDevice] systemName];
        // Set the output to the system name
        return systemName;
    } else {
        // System name not found
        return nil;
    }
}

// System Version
+ (NSString *)systemVersion {
    // Get the current system version
    if ([[UIDevice currentDevice] respondsToSelector:@selector(systemVersion)]) {
        // Make a string for the system version
        NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
        // Set the output to the system version
        return systemVersion;
    } else {
        // System version not found
        return nil;
    }
}

// System Device Type (iPhone1,0) (Formatted = iPhone 1)
+ (NSString *)systemDeviceTypeFormatted:(BOOL)formatted {
    // Set up a Device Type String
    NSString *DeviceType;
    
    // Check if it should be formatted
    if (formatted) {
        // Formatted
        @try {
            // Set up a new Device Type String
            NSString *NewDeviceType;
            // Set up a struct
            struct utsname DT;
            // Get the system information
            uname(&DT);
            // Set the device type to the machine type
            DeviceType = [NSString stringWithFormat:@"%s", DT.machine];
            
            if ([DeviceType isEqualToString:@"i386"])
            NewDeviceType = @"iPhone Simulator";
            else if ([DeviceType isEqualToString:@"iPhone1,1"])
            NewDeviceType = @"iPhone";
            else if ([DeviceType isEqualToString:@"iPhone1,2"])
            NewDeviceType = @"iPhone 3G";
            else if ([DeviceType isEqualToString:@"iPhone2,1"])
            NewDeviceType = @"iPhone 3GS";
            else if ([DeviceType isEqualToString:@"iPhone3,1"])
            NewDeviceType = @"iPhone 4";
            else if ([DeviceType isEqualToString:@"iPhone4,1"])
            NewDeviceType = @"iPhone 4S";
            else if ([DeviceType isEqualToString:@"iPhone5,1"])
            NewDeviceType = @"iPhone 5";
            else if ([DeviceType isEqualToString:@"iPhone5,2"])
            NewDeviceType = @"iPhone 5";
            else if ([DeviceType isEqualToString:@"iPod1,1"])
            NewDeviceType = @"1st Gen iPod";
            else if ([DeviceType isEqualToString:@"iPod2,1"])
            NewDeviceType = @"2nd Gen iPod";
            else if ([DeviceType isEqualToString:@"iPod3,1"])
            NewDeviceType = @"3rd Gen iPod";
            else if ([DeviceType isEqualToString:@"iPad1,1"])
            NewDeviceType = @"iPad";
            else if ([DeviceType isEqualToString:@"iPad2,2"])
            NewDeviceType = @"iPad 2";
            else if ([DeviceType isEqualToString:@"iPad3,3"])
            NewDeviceType = @"New iPad";
            else if ([DeviceType isEqualToString:@"iPad4,4"])
            NewDeviceType = @"iPad 4";
            else if ([DeviceType hasPrefix:@"iPad"])
            NewDeviceType = @"iPad";
            
            // Return the new device type
            return NewDeviceType;
        }
        @catch (NSException *exception) {
            // Error
            return nil;
        }
    } else {
        // Unformatted
        @try {
            // Set up a struct
            struct utsname DT;
            // Get the system information
            uname(&DT);
            // Set the device type to the machine type
            DeviceType = [NSString stringWithFormat:@"%s", DT.machine];
            
            // Return the device type
            return DeviceType;
        }
        @catch (NSException *exception) {
            // Error
            return nil;
        }
    }
}

// Get the Screen Width (X)
+ (NSInteger)screenWidth {
    // Get the screen width
    @try {
        // Screen bounds
        CGRect Rect = [[UIScreen mainScreen] bounds];
        // Find the width (X)
        NSInteger Width = Rect.size.width;
        // Verify validity
        if (Width <= 0) {
            // Invalid Width
            return -1;
        }
        
        // Successful
        return Width;
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Get the Screen Height (Y)
+ (NSInteger)screenHeight {
    // Get the screen height
    @try {
        // Screen bounds
        CGRect Rect = [[UIScreen mainScreen] bounds];
        // Find the Height (Y)
        NSInteger Height = Rect.size.height;
        // Verify validity
        if (Height <= 0) {
            // Invalid Height
            return -1;
        }
        
        // Successful
        return Height;
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Get the Screen Brightness
+ (float)screenBrightness {
    // Get the screen brightness
    @try {
        // Brightness
        float brightness = [UIScreen mainScreen].brightness;
        // Verify validity
        if (brightness < 0.0 || brightness > 1.0) {
            // Invalid brightness
            return -1;
        }
        
        // Successful
        return (brightness * 100);
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Multitasking enabled?
+ (BOOL)multitaskingEnabled {
    // Is multitasking enabled?
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        // Create a bool
        BOOL MultitaskingSupported = [UIDevice currentDevice].multitaskingSupported;
        // Return the value
        return MultitaskingSupported;
    } else {
        // Doesn't respond to selector
        return false;
    }
}

// Battery Information

// Battery Level
+ (float)batteryLevel {
    // Find the battery level
    @try {
        // Get the device
        UIDevice *Device = [UIDevice currentDevice];
        // Set battery monitoring on
        Device.batteryMonitoringEnabled = YES;
        
        // Set up the battery level float
        float BatteryLevel = 0.0;
        // Get the battery level
        float BatteryCharge = [Device batteryLevel];
        
        // Check to make sure the battery level is more than zero
        if (BatteryCharge > 0.0f) {
            // Make the battery level float equal to the charge * 100
            BatteryLevel = BatteryCharge * 100;
        } else {
            // Unable to find the battery level
            return -1;
        }
        
        // Output the battery level
        return BatteryLevel;
    }
    @catch (NSException *exception) {
        // Error out
        return -1;
    }
}

// Charging?
+ (BOOL)charging {
    // Is the battery charging?
    @try {
        // Get the device
        UIDevice *Device = [UIDevice currentDevice];
        // Set battery monitoring on
        Device.batteryMonitoringEnabled = YES;
        
        // Check the battery state
        if ([Device batteryState] == UIDeviceBatteryStateCharging || [Device batteryState] == UIDeviceBatteryStateFull) {
            // Device is charging
            return true;
        } else {
            // Device is not charging
            return false;
        }
    }
    @catch (NSException *exception) {
        // Error out
        return false;
    }
}

// Fully Charged?
+ (BOOL)fullyCharged {
    // Is the battery fully charged?
    @try {
        // Get the device
        UIDevice *Device = [UIDevice currentDevice];
        // Set battery monitoring on
        Device.batteryMonitoringEnabled = YES;
        
        // Check the battery state
        if ([Device batteryState] == UIDeviceBatteryStateFull) {
            // Device is fully charged
            return true;
        } else {
            // Device is not fully charged
            return false;
        }
    }
    @catch (NSException *exception) {
        // Error out
        return false;
    }
}

// Application Information

// Application Version
+ (NSString *)applicationVersion {
    // Get the Application Version Number
    @try {
        // Query the plist for the version
        NSString *Version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        // Validate the Version
        if (Version == nil || Version.length <= 0) {
            // Invalid Version number
            return nil;
        }
        // Successful
        return Version;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}

+ (NSString *)buildVersion {
    @try {
        // Query the plist for the version
        NSString *Version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
        // Validate the Version
        if (Version == nil || Version.length <= 0) {
            // Invalid Version number
            return nil;
        }
        // Successful
        return Version;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}


#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


// Clipboard Content
+ (NSString *)clipboardContent {
    // Get the string content of the clipboard (copy, paste)
    @try {
        // Get the Pasteboard
        UIPasteboard *PasteBoard = [UIPasteboard generalPasteboard];
        // Get the string value of the pasteboard
        NSString *ClipboardContent = [PasteBoard string];
        // Check for validity
        if (ClipboardContent == nil || ClipboardContent.length <= 0) {
            // Error, invalid pasteboard
            return nil;
        }
        // Successful
        return ClipboardContent;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}

// Carrier Information

// Carrier Name
+ (NSString *)carrierName {
    // Get the carrier name
    @try {
        // Get the Telephony Network Info
        CTTelephonyNetworkInfo *TelephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
        // Get the carrier
        CTCarrier *Carrier = [TelephonyInfo subscriberCellularProvider];
        // Get the carrier name
        NSString *CarrierName = [Carrier carrierName];
        
        // Check to make sure it's valid
        if (CarrierName == nil || CarrierName.length <= 0) {
            // Return unknown
            return nil;
        }
        
        // Return the name
        return CarrierName;
    }
    @catch (NSException *exception) {
        // Error finding the name
        return nil;
    }
}

// Carrier Country
+ (NSString *)carrierCountry {
    // Get the country that the carrier is located in
    @try {
        // Get the locale
        NSLocale *CurrentCountry = [NSLocale currentLocale];
        // Get the country Code
        NSString *Country = [CurrentCountry objectForKey:NSLocaleCountryCode];
        // Check if it returned anything
        if (Country == nil || Country.length <= 0) {
            // No country found
            return nil;
        }
        // Return the country
        return Country;
    }
    @catch (NSException *exception) {
        // Failed, return nil
        return nil;
    }
}

@end
