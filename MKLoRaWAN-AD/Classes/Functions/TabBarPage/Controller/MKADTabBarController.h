//
//  MKADTabBarController.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKADTabBarControllerDelegate <NSObject>

/// 返回到扫描页面，肯定需要开启扫描，当dfu升级之后返回扫描页面，则需要重新设置扫描代理
/// @param need YES:DFU升级情况下返回，需要设置扫描代理,NO:不需要重设代理
- (void)mk_ad_needResetScanDelegate:(BOOL)need;

@end

@interface MKADTabBarController : UITabBarController

@property (nonatomic, weak)id <MKADTabBarControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
