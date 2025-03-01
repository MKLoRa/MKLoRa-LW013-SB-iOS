//
//  MKADOnOffSettingsModel.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKADOnOffSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKADInterface.h"

@interface MKADOnOffSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKADOnOffSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readOnOffMethod]) {
            [self operationFailedBlockWithMsg:@"Read ON/Off Method Error" block:failedBlock];
            return;
        }
        
        if (![self readShutDownPayload]) {
            [self operationFailedBlockWithMsg:@"Read Shut-Down Payload Error" block:failedBlock];
            return;
        }
        
        if (![self readOffByButton]) {
            [self operationFailedBlockWithMsg:@"Read Off By Button Error" block:failedBlock];
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

- (BOOL)readOnOffMethod {
    __block BOOL success = NO;
    [MKADInterface ad_readMagnetTurnOnMethodWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.onOffMethod = [returnData[@"result"][@"method"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readShutDownPayload {
    __block BOOL success = NO;
    [MKADInterface ad_readShutdownPayloadStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.shutDownPayload = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readOffByButton {
    __block BOOL success = NO;
    [MKADInterface ad_readHallPowerOffStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.offByButton = [returnData[@"result"][@"isOn"] boolValue];
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
        NSError *error = [[NSError alloc] initWithDomain:@"OnOffSettingsParams"
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
        _readQueue = dispatch_queue_create("OnOffSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
