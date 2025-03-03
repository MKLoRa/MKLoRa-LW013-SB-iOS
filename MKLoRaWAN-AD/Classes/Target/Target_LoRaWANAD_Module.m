//
//  Target_LoRaWANAD_Module.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "Target_LoRaWANAD_Module.h"

#import "MKADScanController.h"

#import "MKADAboutController.h"

@implementation Target_LoRaWANAD_Module

/// 扫描页面
- (UIViewController *)Action_LoRaWANAD_Module_ScanController:(NSDictionary *)params {
    MKADScanController *vc = [[MKADScanController alloc] init];
    return vc;
}

/// 关于页面
- (UIViewController *)Action_LoRaWANAD_Module_AboutController:(NSDictionary *)params {
    return [[MKADAboutController alloc] init];
}

@end
