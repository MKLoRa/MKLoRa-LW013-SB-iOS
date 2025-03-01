//
//  MKADAlarmTypeSettingsModel.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2025/3/1.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKADAlarmTypeSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKADInterface.h"
#import "MKADInterface+MKADConfig.h"

@interface MKADAlarmTypeSettingsModel ()

@property (nonatomic, assign)NSInteger alarmType;

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKADAlarmTypeSettingsModel

- (instancetype)initWithAlarmType:(NSInteger)alarmType {
    if (self = [super init]) {
        self.alarmType = alarmType;
    }
    return self;
}

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFunctionSwitch]) {
            [self operationFailedBlockWithMsg:@"Read Fuction Switch Error" block:failedBlock];
            return;
        }
        if (![self readBuzzerTriggerType]) {
            [self operationFailedBlockWithMsg:@"Read Buzzer Trigger Type Error" block:failedBlock];
            return;
        }
        if (![self readReportInterval]) {
            [self operationFailedBlockWithMsg:@"Read Report Interval Error" block:failedBlock];
            return;
        }
        if (![self readLongPressTime]) {
            [self operationFailedBlockWithMsg:@"Read Long Press Time Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configFunctionSwitch]) {
            [self operationFailedBlockWithMsg:@"Config Fuction Switch Error" block:failedBlock];
            return;
        }
        if (![self configBuzzerTriggerType]) {
            [self operationFailedBlockWithMsg:@"Config Buzzer Trigger Type Error" block:failedBlock];
            return;
        }
        if (![self configReportInterval]) {
            [self operationFailedBlockWithMsg:@"Config Report Interval Error" block:failedBlock];
            return;
        }
        if (![self configLongPressTime]) {
            [self operationFailedBlockWithMsg:@"Config Long Press Time Error" block:failedBlock];
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
- (BOOL)readFunctionSwitch {
    __block BOOL success = NO;
    [MKADInterface ad_readAlarmFunctionSwitchWithType:self.alarmType sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        self.exit = [returnData[@"result"][@"exit"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFunctionSwitch {
    __block BOOL success = NO;
    [MKADInterface ad_configAlarmFunctionSwitch:self.isOn exitByButton:self.exit alarmType:self.alarmType sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBuzzerTriggerType {
    __block BOOL success = NO;
    [MKADInterface ad_readBuzzerTypeAlarmTriggerWithType:self.alarmType sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.triggerType = [returnData[@"result"][@"type"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBuzzerTriggerType {
    __block BOOL success = NO;
    [MKADInterface ad_configBuzzerTypeAlarmTrigger:self.triggerType alarmType:self.alarmType sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readReportInterval {
    __block BOOL success = NO;
    [MKADInterface ad_readAlarmReportIntervalWithType:self.alarmType sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.interval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configReportInterval {
    __block BOOL success = NO;
    [MKADInterface ad_configAlarmReportInterval:[self.interval integerValue] alarmType:self.alarmType sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLongPressTime {
    __block BOOL success = NO;
    [MKADInterface ad_readAlarmExitLongPressTimeWithType:self.alarmType sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.time = returnData[@"result"][@"time"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLongPressTime {
    __block BOOL success = NO;
    [MKADInterface ad_configAlarmExitLongPressTime:[self.time integerValue] alarmType:self.alarmType sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"AlarmTypeSettingsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.time) || [self.time integerValue] < 10 || [self.time integerValue] > 15) {
        return NO;
    }
    if (!ValidStr(self.interval) || [self.interval integerValue] < 1 || [self.interval integerValue] > 1440) {
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
        _readQueue = dispatch_queue_create("AlarmTypeSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
