//
//  LCLDeviceTool.h
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/29.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCLDeviceTool : NSObject

#pragma mark - 相机、相册授权


#pragma mark - 跳转至app权限设置界面
+ (void)lcl_gotoSettingPage;

#pragma mark - 闪光灯
/**
 后置摄像头是否支持闪光灯
 */
+ (BOOL)lcl_isFlashAvailableForRear;

/**
 前置置摄像头是否支持闪光灯
 */
+ (BOOL)lcl_isFlashAvailableForFront;

#pragma mark - 摄像头
/**
 后置摄像头是否可用
 */
+ (BOOL)lcl_isRearCameraAvailable;

/**
 前置摄像头是否可用
 */
+ (BOOL)lcl_isFrontCameraAvailable;

#pragma mark - 相机、相册
/**
 判断设备是否支持相机
 */
+ (BOOL)lcl_isCameraAvailable;

/**
 判断设备是否支持图片库
 */
+ (BOOL)lcl_isPhotoLibraryAvailable;

/**
 判断设备是否支持相册
 */
+ (BOOL)lcl_isPhotoAlbumAvailable;


/**
 系统版本号
 */
+ (double)lcl_systemVersion;

#pragma mark - 设备空间
/**
 设备总空间
 */
+ (int64_t)lcl_deviceTotalDiskSpace;

/**
 未使用空间
 */
+ (int64_t)lcl_deviceFreeDiskSpace;

/**
 已使用空间
 */
+ (int64_t)lcl_deviceUsedDiskSpace;

#pragma mark - 设备地址

/**
 获取设备ip地址
 */
+ (NSString *)lcl_deviceIPAddress;


/**
 设备类型
 用户使用的设备类型 几代iPhone
 */
+ (NSString *)lcl_deviceType;

@end
