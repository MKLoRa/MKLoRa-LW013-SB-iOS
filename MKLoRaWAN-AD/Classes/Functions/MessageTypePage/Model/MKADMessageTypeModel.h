//
//  MKADMessageTypeModel.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADMessageTypeModel : NSObject

@property (nonatomic, assign)NSInteger heartbeatType;

@property (nonatomic, assign)NSInteger heartbeatMaxTimes;

@property (nonatomic, assign)NSInteger lowPowerType;

@property (nonatomic, assign)NSInteger lowPowerMaxTimes;

@property (nonatomic, assign)NSInteger eventType;

@property (nonatomic, assign)NSInteger eventMaxTimes;

@property (nonatomic, assign)NSInteger alarmType;

@property (nonatomic, assign)NSInteger alarmLimitMaxTimes;


- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
