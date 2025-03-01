//
//  Target_LoRaWANAD_Module.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_LoRaWANAD_Module : NSObject


/// 扫描页面
/// - Parameter params: @{@"deviceType":@"0"}
- (UIViewController *)Action_LoRaWANAD_Module_ScanController:(NSDictionary *)params;

/// 关于页面
- (UIViewController *)Action_LoRaWANAD_Module_AboutController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
