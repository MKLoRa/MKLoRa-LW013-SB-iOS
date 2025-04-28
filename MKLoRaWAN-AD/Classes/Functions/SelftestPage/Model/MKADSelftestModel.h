//
//  MKADSelftestModel.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADSelftestModel : NSObject

@property (nonatomic, copy)NSString *pcbaStatus;

/// 0-2.2v  20-3.2v
@property (nonatomic, assign)NSInteger nonAlarmVoltageThreshold;

@property (nonatomic, copy)NSString *nonAlarmSampleInterval;

@property (nonatomic, copy)NSString *nonAlarmSampleTimes;

/// 0-2.2v  20-3.2v
@property (nonatomic, assign)NSInteger alarmVoltageThreshold;

@property (nonatomic, copy)NSString *alarmSampleInterval;

@property (nonatomic, copy)NSString *alarmSampleTimes;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
