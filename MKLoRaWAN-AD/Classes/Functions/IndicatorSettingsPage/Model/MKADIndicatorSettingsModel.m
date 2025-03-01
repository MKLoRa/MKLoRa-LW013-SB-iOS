//
//  MKADIndicatorSettingsModel.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKADIndicatorSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKADInterface.h"
#import "MKADInterface+MKADConfig.h"

@interface MKADIndicatorSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKADIndicatorSettingsModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readIndicatorSettings]) {
            [self operationFailedBlockWithMsg:@"Read Indicator Settings Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configIndicatorSettings]) {
            [self operationFailedBlockWithMsg:@"Config Indicator Settings Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (BOOL)readIndicatorSettings {
    __block BOOL success = NO;
    [MKADInterface ad_readIndicatorSettingsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.LowPower = [returnData[@"result"][@"indicatorSettings"][@"lowPower"] boolValue];
        self.NetworkCheck = [returnData[@"result"][@"indicatorSettings"][@"networkCheck"] boolValue];
        self.Broadcast = [returnData[@"result"][@"indicatorSettings"][@"broadcast"] boolValue];
        self.Alarm1Trigger = [returnData[@"result"][@"indicatorSettings"][@"alarm1Trigger"] boolValue];
        self.Alarm1Exit = [returnData[@"result"][@"indicatorSettings"][@"alarm1Exit"] boolValue];
        self.Alarm2Trigger = [returnData[@"result"][@"indicatorSettings"][@"alarm2Trigger"] boolValue];
        self.Alarm2Exit = [returnData[@"result"][@"indicatorSettings"][@"alarm2Exit"] boolValue];
        self.Alarm3Trigger = [returnData[@"result"][@"indicatorSettings"][@"alarm3Trigger"] boolValue];
        self.Alarm3Exit = [returnData[@"result"][@"indicatorSettings"][@"alarm3Exit"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configIndicatorSettings {
    __block BOOL success = NO;
    [MKADInterface ad_configIndicatorSettings:self sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"indicatorSettingsParams"
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
        _readQueue = dispatch_queue_create("indicatorSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
