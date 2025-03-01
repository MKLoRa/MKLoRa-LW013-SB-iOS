//
//  MKADBatteryConsumptionModel.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/8.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKADBatteryConsumptionModel.h"

#import "MKMacroDefines.h"

#import "MKADInterface.h"

@interface MKADBatteryConsumptionModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKADBatteryConsumptionModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readCurrent]) {
            [self operationFailedBlockWithMsg:@"Read Current Cycle Battery Information Error" block:failedBlock];
            return;
        }
        if (![self readLast]) {
            [self operationFailedBlockWithMsg:@"Read Last Cycle Battery Information Error" block:failedBlock];
            return;
        }
        if (![self readAll]) {
            [self operationFailedBlockWithMsg:@"Read All Cycle Battery Information Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readCurrent {
    __block BOOL success = NO;
    [MKADInterface ad_readBatteryInformationWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.currentInfo = returnData[@"result"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLast {
    __block BOOL success = NO;
    [MKADInterface ad_readLastCycleBatteryInformationWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lastInfo = returnData[@"result"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAll {
    __block BOOL success = NO;
    [MKADInterface ad_readAllCycleBatteryInformationWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.allInfo = returnData[@"result"];
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
        NSError *error = [[NSError alloc] initWithDomain:@"BatteryConsumption"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    });
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
        _readQueue = dispatch_queue_create("BatteryConsumptionQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
