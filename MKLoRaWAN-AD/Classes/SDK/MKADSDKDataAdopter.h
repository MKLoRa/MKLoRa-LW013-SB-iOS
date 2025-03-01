//
//  MKADSDKDataAdopter.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKADSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKADSDKDataAdopter : NSObject

+ (NSString *)lorawanRegionString:(mk_ad_loraWanRegion)region;

+ (NSString *)fetchTxPower:(mk_ad_txPower)txPower;

/// 实际值转换为0dBm、4dBm等
/// @param content content
+ (NSString *)fetchTxPowerValueString:(NSString *)content;

+ (NSDictionary *)fetchIndicatorSettings:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
