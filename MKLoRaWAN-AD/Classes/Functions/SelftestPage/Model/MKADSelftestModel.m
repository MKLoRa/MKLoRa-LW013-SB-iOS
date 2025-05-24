//
//  MKADSelftestModel.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKADSelftestModel.h"

#import "MKMacroDefines.h"

#import "MKADInterface.h"
#import "MKADInterface+MKADConfig.h"

@interface MKADSelftestModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKADSelftestModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPCBAStatus]) {
            [self operationFailedBlockWithMsg:@"Read PCBA Status Error" block:failedBlock];
            return;
        }
        if (![self readSelftestStatus]) {
            [self operationFailedBlockWithMsg:@"Read Self Test Status Error" block:failedBlock];
            return;
        }
        if (![self readNonAlarmVoltageThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Non-Alarm Voltage Threshold Error" block:failedBlock];
            return;
        }
        if (![self readNonAlarmSampleInterval]) {
            [self operationFailedBlockWithMsg:@"Read Non-Alarm Sample Interval Error" block:failedBlock];
            return;
        }
        if (![self readNonAlarmSampleTimes]) {
            [self operationFailedBlockWithMsg:@"Read Non-Alarm Sample Times Error" block:failedBlock];
            return;
        }
        if (![self readAlarmVoltageThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Alarm Voltage Threshold Error" block:failedBlock];
            return;
        }
        if (![self readAlarmSampleInterval]) {
            [self operationFailedBlockWithMsg:@"Read Alarm Sample Interval Error" block:failedBlock];
            return;
        }
        if (![self readAlarmSampleTimes]) {
            [self operationFailedBlockWithMsg:@"Read Alarm Sample Times Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        
        if (![self configNonAlarmVoltageThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Non-Alarm Voltage Threshold Error" block:failedBlock];
            return;
        }
        if (![self configNonAlarmSampleInterval]) {
            [self operationFailedBlockWithMsg:@"Config Non-Alarm Sample Interval Error" block:failedBlock];
            return;
        }
        if (![self configNonAlarmSampleTimes]) {
            [self operationFailedBlockWithMsg:@"Config Non-Alarm Sample Times Error" block:failedBlock];
            return;
        }
        if (![self configAlarmVoltageThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Alarm Voltage Threshold Error" block:failedBlock];
            return;
        }
        if (![self configAlarmSampleInterval]) {
            [self operationFailedBlockWithMsg:@"Config Alarm Sample Interval Error" block:failedBlock];
            return;
        }
        if (![self configAlarmSampleTimes]) {
            [self operationFailedBlockWithMsg:@"Config Alarm Sample Times Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readPCBAStatus {
    __block BOOL success = NO;
    [MKADInterface ad_readPCBAStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.pcbaStatus = returnData[@"result"][@"status"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSelftestStatus {
    __block BOOL success = NO;
    [MKADInterface ad_readSelftestStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSString *binary = [self binaryByhex:returnData[@"result"][@"status"]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNonAlarmVoltageThreshold {
    __block BOOL success = NO;
    [MKADInterface ad_readLowPowerNonAlarmVoltageThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.nonAlarmVoltageThreshold = [returnData[@"result"][@"threshold"] integerValue] - 44;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNonAlarmVoltageThreshold {
    __block BOOL success = NO;
    [MKADInterface ad_configLowPowerNonAlarmVoltageThreshold:(self.nonAlarmVoltageThreshold + 44) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNonAlarmSampleInterval {
    __block BOOL success = NO;
    [MKADInterface ad_readLowPowerNonAlarmMinSampleIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.nonAlarmSampleInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNonAlarmSampleInterval {
    __block BOOL success = NO;
    [MKADInterface ad_configLowPowerNonAlarmMinSampleInterval:[self.nonAlarmSampleInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNonAlarmSampleTimes {
    __block BOOL success = NO;
    [MKADInterface ad_readLowPowerNonAlarmSampleTimesWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.nonAlarmSampleTimes = returnData[@"result"][@"times"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNonAlarmSampleTimes {
    __block BOOL success = NO;
    [MKADInterface ad_configLowPowerNonAlarmSampleTimes:[self.nonAlarmSampleTimes integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAlarmVoltageThreshold {
    __block BOOL success = NO;
    [MKADInterface ad_readLowPowerAlarmVoltageThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.alarmVoltageThreshold = [returnData[@"result"][@"threshold"] integerValue] - 44;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAlarmVoltageThreshold {
    __block BOOL success = NO;
    [MKADInterface ad_configLowPowerAlarmVoltageThreshold:(self.alarmVoltageThreshold + 44) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAlarmSampleInterval {
    __block BOOL success = NO;
    [MKADInterface ad_readLowPowerAlarmMinSampleIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.alarmSampleInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAlarmSampleInterval {
    __block BOOL success = NO;
    [MKADInterface ad_configLowPowerAlarmMinSampleInterval:[self.alarmSampleInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAlarmSampleTimes {
    __block BOOL success = NO;
    [MKADInterface ad_readLowPowerAlarmSampleTimesWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.alarmSampleTimes = returnData[@"result"][@"times"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAlarmSampleTimes {
    __block BOOL success = NO;
    [MKADInterface ad_configLowPowerAlarmSampleTimes:[self.alarmSampleTimes integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (NSString *)binaryByhex:(NSString *)hex {
    NSDictionary *hexDic = @{
                             @"0":@"0000",@"1":@"0001",@"2":@"0010",
                             @"3":@"0011",@"4":@"0100",@"5":@"0101",
                             @"6":@"0110",@"7":@"0111",@"8":@"1000",
                             @"9":@"1001",@"A":@"1010",@"a":@"1010",
                             @"B":@"1011",@"b":@"1011",@"C":@"1100",
                             @"c":@"1100",@"D":@"1101",@"d":@"1101",
                             @"E":@"1110",@"e":@"1110",@"F":@"1111",
                             @"f":@"1111",
                             };
    NSString *binaryString = @"";
    for (int i=0; i<[hex length]; i++) {
        NSRange rage;
        rage.length = 1;
        rage.location = i;
        NSString *key = [hex substringWithRange:rage];
        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,
                        [NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    return binaryString;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"selftest"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    });
}

- (BOOL)validParams {
    if (self.nonAlarmVoltageThreshold < 0 || self.nonAlarmVoltageThreshold > 20) {
        return NO;
    }
    if (!ValidStr(self.nonAlarmSampleInterval) || [self.nonAlarmSampleInterval integerValue] < 1 || [self.nonAlarmSampleInterval integerValue] > 1440) {
        return NO;
    }
    if (!ValidStr(self.nonAlarmSampleTimes) || [self.nonAlarmSampleTimes integerValue] < 1 || [self.nonAlarmSampleTimes integerValue] > 100) {
        return NO;
    }
    if (self.alarmVoltageThreshold < 0 || self.alarmVoltageThreshold > 20) {
        return NO;
    }
    if (!ValidStr(self.alarmSampleInterval) || [self.alarmSampleInterval integerValue] < 1 || [self.alarmSampleInterval integerValue] > 1440) {
        return NO;
    }
    if (!ValidStr(self.alarmSampleTimes) || [self.alarmSampleTimes integerValue] < 1 || [self.alarmSampleTimes integerValue] > 100) {
        return NO;
    }
    return YES;
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("selftestQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
