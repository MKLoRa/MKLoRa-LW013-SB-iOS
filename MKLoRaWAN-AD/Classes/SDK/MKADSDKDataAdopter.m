//
//  MKADSDKDataAdopter.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKADSDKDataAdopter.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

@implementation MKADSDKDataAdopter

+ (NSString *)lorawanRegionString:(mk_ad_loraWanRegion)region {
    switch (region) {
        case mk_ad_loraWanRegionAS923:
            return @"00";
        case mk_ad_loraWanRegionAU915:
            return @"01";
        case mk_ad_loraWanRegionEU868:
            return @"05";
        case mk_ad_loraWanRegionKR920:
            return @"06";
        case mk_ad_loraWanRegionIN865:
            return @"07";
        case mk_ad_loraWanRegionUS915:
            return @"08";
        case mk_ad_loraWanRegionRU864:
            return @"09";
        case mk_ad_loraWanRegionAS923_1:
            return @"0a";
        case mk_ad_loraWanRegionAS923_2:
            return @"0b";
        case mk_ad_loraWanRegionAS923_3:
            return @"0c";
        case mk_ad_loraWanRegionAS923_4:
            return @"0d";
    }
}

+ (NSString *)fetchTxPower:(mk_ad_txPower)txPower {
    switch (txPower) {
        case mk_ad_txPower4dBm:
            return @"04";
        case mk_ad_txPower3dBm:
            return @"03";
        case mk_ad_txPower0dBm:
            return @"00";
        case mk_ad_txPowerNeg4dBm:
            return @"fc";
        case mk_ad_txPowerNeg8dBm:
            return @"f8";
        case mk_ad_txPowerNeg12dBm:
            return @"f4";
        case mk_ad_txPowerNeg16dBm:
            return @"f0";
        case mk_ad_txPowerNeg20dBm:
            return @"ec";
        case mk_ad_txPowerNeg40dBm:
            return @"d8";
    }
}

+ (NSString *)fetchTxPowerValueString:(NSString *)content {
    if ([content isEqualToString:@"04"]) {
        return @"4dBm";
    }
    if ([content isEqualToString:@"03"]) {
        return @"3dBm";
    }
    if ([content isEqualToString:@"00"]) {
        return @"0dBm";
    }
    if ([content isEqualToString:@"fc"]) {
        return @"-4dBm";
    }
    if ([content isEqualToString:@"f8"]) {
        return @"-8dBm";
    }
    if ([content isEqualToString:@"f4"]) {
        return @"-12dBm";
    }
    if ([content isEqualToString:@"f0"]) {
        return @"-16dBm";
    }
    if ([content isEqualToString:@"ec"]) {
        return @"-20dBm";
    }
    if ([content isEqualToString:@"d8"]) {
        return @"-40dBm";
    }
    return @"0dBm";
}

+ (NSDictionary *)fetchIndicatorSettings:(NSString *)content {
    BOOL LowPower = [[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"];
    BOOL broadcast = [[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"];
    BOOL networkCheck = [[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"];
    BOOL alarm1Trigger = [[content substringWithRange:NSMakeRange(6, 2)] isEqualToString:@"01"];
    BOOL alarm1Exit = [[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"];
    BOOL alarm2Trigger = [[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"];
    BOOL alarm2Exit = [[content substringWithRange:NSMakeRange(12, 2)] isEqualToString:@"01"];
    BOOL alarm3Trigger = [[content substringWithRange:NSMakeRange(14, 2)] isEqualToString:@"01"];
    BOOL alarm3Exit = [[content substringWithRange:NSMakeRange(16, 2)] isEqualToString:@"01"];
    
    return @{
        @"lowPower":@(LowPower),
        @"networkCheck":@(networkCheck),
        @"broadcast":@(broadcast),
        @"alarm1Trigger":@(alarm1Trigger),
        @"alarm1Exit":@(alarm1Exit),
        @"alarm2Trigger":@(alarm2Trigger),
        @"alarm2Exit":@(alarm2Exit),
        @"alarm3Trigger":@(alarm3Trigger),
        @"alarm3Exit":@(alarm3Exit),
    };
}

@end
