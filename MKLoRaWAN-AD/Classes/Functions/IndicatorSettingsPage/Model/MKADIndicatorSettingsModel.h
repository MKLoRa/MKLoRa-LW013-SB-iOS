//
//  MKADIndicatorSettingsModel.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKADSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKADIndicatorSettingsModel : NSObject<mk_ad_indicatorSettingsProtocol>

@property (nonatomic, assign)BOOL LowPower;
@property (nonatomic, assign)BOOL NetworkCheck;
@property (nonatomic, assign)BOOL Broadcast;
@property (nonatomic, assign)BOOL Alarm1Trigger;
@property (nonatomic, assign)BOOL Alarm1Exit;
@property (nonatomic, assign)BOOL Alarm2Trigger;
@property (nonatomic, assign)BOOL Alarm2Exit;
@property (nonatomic, assign)BOOL Alarm3Trigger;
@property (nonatomic, assign)BOOL Alarm3Exit;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
