//
//  LCLDeviceTool.m
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/29.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import "LCLDeviceTool.h"

#import <UIKit/UIKit.h>
#import "sys/utsname.h"
#import <AdSupport/AdSupport.h>

#import <CommonCrypto/CommonDigest.h>

// 下面是获取mac地址需要导入的头文件
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <arpa/inet.h>

// 下面是获取ip需要的头文件
#include <ifaddrs.h>

// 获取CPU信息所需要引入的头文件
#include <mach/mach.h>
#import <malloc/malloc.h>

@implementation LCLDeviceTool

+ (void)lcl_gotoSettingPage {

    UIApplication *app = [UIApplication sharedApplication];
    
    
    double vers = [self lcl_systemVersion];
    if (vers < 8.0) {
        return;
    }
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([app canOpenURL:url]) {
        
        if (vers >= 10.0) {
            [app openURL:url options:@{} completionHandler:nil];
        } else {
            [app openURL:url];
        }
    }
}

// MARK: - 后置摄像头是否支持闪光灯
+ (BOOL)lcl_isFlashAvailableForRear {
    
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
}

// MARK: - 前置摄像头是否支持闪光灯
+ (BOOL)lcl_isFlashAvailableForFront {

    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceFront];
}

// MARK: - 前置摄像头
+ (BOOL)lcl_isFrontCameraAvailable {
    
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// MARK: - 后置摄像头
+ (BOOL)lcl_isRearCameraAvailable {
    
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

// MARK: - 相机
+ (BOOL)lcl_isCameraAvailable {

    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// MARK: - 图片库
+ (BOOL)lcl_isPhotoLibraryAvailable {

    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

// MARK: - 相册
+ (BOOL)lcl_isPhotoAlbumAvailable {

    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}

+ (double)lcl_systemVersion {

    return [UIDevice currentDevice].systemVersion.doubleValue;
}

#pragma mark - 磁盘空间
// MARK: - 获取磁盘总空间
+ (int64_t)lcl_deviceTotalDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}
// MARK: - 获取未使用的磁盘空间
+ (int64_t)lcl_deviceFreeDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}
// MARK: - 获取已使用的磁盘空间
+ (int64_t)lcl_deviceUsedDiskSpace {
    int64_t totalDisk = [self lcl_deviceTotalDiskSpace];
    int64_t freeDisk = [self lcl_deviceUsedDiskSpace];
    if (totalDisk < 0 || freeDisk < 0) return -1;
    int64_t usedDisk = totalDisk - freeDisk;
    if (usedDisk < 0) usedDisk = -1;
    return usedDisk;
}

#pragma mark - 设备地址
// MARK: - 设备ip地址
+ (NSString *)lcl_deviceIPAddress {
    
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}

#pragma mark - 设备型号
+ (NSString *)lcl_deviceType {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithFormat:@"%s", systemInfo.machine];
    
    NSString *correspondVersion = platform;
    
    if ([correspondVersion isEqualToString:@"i386"])                return@"Simulator";
    else if ([correspondVersion isEqualToString:@"x86_64"])         return @"Simulator";
    
    else if ([correspondVersion isEqualToString:@"iPhone1,1"])      return@"iPhone 1";
    else if ([correspondVersion isEqualToString:@"iPhone1,2"])      return@"iPhone 3";
    else if ([correspondVersion isEqualToString:@"iPhone2,1"])      return@"iPhone 3S";
    else if ([correspondVersion isEqualToString:@"iPhone3,1"] || [correspondVersion isEqualToString:@"iPhone3,2"])   return@"iPhone 4";
    else if ([correspondVersion isEqualToString:@"iPhone4,1"])      return@"iPhone 4S";
    else if ([correspondVersion isEqualToString:@"iPhone5,1"] || [correspondVersion isEqualToString:@"iPhone5,2"])   return @"iPhone 5";
    else if ([correspondVersion isEqualToString:@"iPhone5,3"] || [correspondVersion isEqualToString:@"iPhone5,4"])   return @"iPhone 5C";
    else if ([correspondVersion isEqualToString:@"iPhone6,1"] || [correspondVersion isEqualToString:@"iPhone6,2"])   return @"iPhone 5S";
    else if ([correspondVersion isEqualToString:@"iPhone7,1"])      return @"iphone 6Plus";
    else if ([correspondVersion isEqualToString:@"iPhone7,2"])      return @"iphone 6";
    else if ([correspondVersion isEqualToString:@"iPhone8,1"])      return @"iphone 6s";
    else if ([correspondVersion isEqualToString:@"iPhone8,2"])      return @"iphone 6sPlus";
    else if ([correspondVersion isEqualToString:@"iPhone8,4"])      return @"iPhone SE";
    else if ([correspondVersion isEqualToString:@"iPhone9,1"])      return @"iPhone 7";
    else if ([correspondVersion isEqualToString:@"iPhone9,2"])      return @"iPhone 7 Plus";
    
    
    else if ([correspondVersion isEqualToString:@"iPod1,1"])        return@"iPod Touch 1";
    else if ([correspondVersion isEqualToString:@"iPod2,1"])        return@"iPod Touch 2";
    else if ([correspondVersion isEqualToString:@"iPod3,1"])        return@"iPod Touch 3";
    else if ([correspondVersion isEqualToString:@"iPod4,1"])        return@"iPod Touch 4";
    else if ([correspondVersion isEqualToString:@"iPod5,1"])        return@"iPod Touch 5";
    
    else if ([correspondVersion isEqualToString:@"iPad1,1"])        return@"iPad 1";
    else if ([correspondVersion isEqualToString:@"iPad2,1"] || [correspondVersion isEqualToString:@"iPad2,2"] || [correspondVersion isEqualToString:@"iPad2,3"] || [correspondVersion isEqualToString:@"iPad2,4"])              return@"iPad 2";
    else if ([correspondVersion isEqualToString:@"iPad2,5"] || [correspondVersion isEqualToString:@"iPad2,6"] || [correspondVersion isEqualToString:@"iPad2,7"] )      return @"iPad Mini";
    else if ([correspondVersion isEqualToString:@"iPad3,1"] || [correspondVersion isEqualToString:@"iPad3,2"] || [correspondVersion isEqualToString:@"iPad3,3"] || [correspondVersion isEqualToString:@"iPad3,4"] || [correspondVersion isEqualToString:@"iPad3,5"] || [correspondVersion isEqualToString:@"iPad3,6"])      return @"iPad 3";
    
    return @"iphone";
}




@end
