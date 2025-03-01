//
//  MKADAlarmTypeSettingsModel.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2025/3/1.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADAlarmTypeSettingsModel : NSObject

@property (nonatomic, assign)BOOL isOn;

/// 0:No    1:Normal    2:Alarm
@property (nonatomic, assign)NSInteger triggerType;

@property (nonatomic, copy)NSString *interval;

@property (nonatomic, assign)BOOL exit;

@property (nonatomic, copy)NSString *time;

- (instancetype)initWithAlarmType:(NSInteger)alarmType;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
