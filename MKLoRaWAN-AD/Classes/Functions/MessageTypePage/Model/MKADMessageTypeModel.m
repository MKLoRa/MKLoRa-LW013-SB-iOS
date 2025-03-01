//
//  MKADMessageTypeModel.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKADMessageTypeModel.h"

#import "MKMacroDefines.h"

#import "MKADInterface.h"
#import "MKADInterface+MKADConfig.h"

@interface MKADMessageTypeModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKADMessageTypeModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        
        if (![self readHeartbeatPayload]) {
            [self operationFailedBlockWithMsg:@"Read Heartbeat Payload Error" block:failedBlock];
            return;
        }
        
        if (![self readLowPowerPayload]) {
            [self operationFailedBlockWithMsg:@"Read Low-Power Payload Error" block:failedBlock];
            return;
        }
        
        if (![self readEventPayload]) {
            [self operationFailedBlockWithMsg:@"Read Event Payload Error" block:failedBlock];
            return;
        }
        
        if (![self readAlarmPayload]) {
            [self operationFailedBlockWithMsg:@"Read Alarm Payload Error" block:failedBlock];
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
        
        if (![self configHeartbeatPayload]) {
            [self operationFailedBlockWithMsg:@"Config Heartbeat Payload Error" block:failedBlock];
            return;
        }
        
        if (![self configLowPowerPayload]) {
            [self operationFailedBlockWithMsg:@"Config Low-Power Payload Error" block:failedBlock];
            return;
        }
        
        if (![self configEventPayload]) {
            [self operationFailedBlockWithMsg:@"Config Event Payload Error" block:failedBlock];
            return;
        }
        
        if (![self configAlarmPayload]) {
            [self operationFailedBlockWithMsg:@"Config Alarm Payload Error" block:failedBlock];
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
- (BOOL)readHeartbeatPayload {
    __block BOOL success = NO;
    [MKADInterface ad_readHeartbeatPayloadDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.heartbeatType = [returnData[@"result"][@"type"] integerValue];
        self.heartbeatMaxTimes = [returnData[@"result"][@"retransmissionTimes"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configHeartbeatPayload {
    __block BOOL success = NO;
    [MKADInterface ad_configHeartbeatPayloadWithMessageType:self.heartbeatType retransmissionTimes:(self.heartbeatMaxTimes + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLowPowerPayload {
    __block BOOL success = NO;
    [MKADInterface ad_readLowPowerPayloadDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lowPowerType = [returnData[@"result"][@"type"] integerValue];
        self.lowPowerMaxTimes = [returnData[@"result"][@"retransmissionTimes"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLowPowerPayload {
    __block BOOL success = NO;
    [MKADInterface ad_configLowPowerPayloadWithMessageType:self.lowPowerType retransmissionTimes:(self.lowPowerMaxTimes + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readEventPayload {
    __block BOOL success = NO;
    [MKADInterface ad_readEventPayloadDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.eventType = [returnData[@"result"][@"type"] integerValue];
        self.eventMaxTimes = [returnData[@"result"][@"retransmissionTimes"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configEventPayload {
    __block BOOL success = NO;
    [MKADInterface ad_configEventPayloadWithMessageType:self.eventType retransmissionTimes:(self.eventMaxTimes + 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAlarmPayload {
    __block BOOL success = NO;
    [MKADInterface ad_readAlarmPayloadDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.alarmType = [returnData[@"result"][@"type"] integerValue];
        self.alarmLimitMaxTimes = [returnData[@"result"][@"retransmissionTimes"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAlarmPayload {
    __block BOOL success = NO;
    [MKADInterface ad_configAlarmPayloadWithMessageType:self.alarmType retransmissionTimes:(self.alarmLimitMaxTimes + 1) sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"MessageTypeParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
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
        _readQueue = dispatch_queue_create("MessageTypeQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
