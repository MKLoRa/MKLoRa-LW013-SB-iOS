//
//  MKADOperation.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKADOperation.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import <MKBaseBleModule/MKBLEBaseSDKDefines.h>

#import "MKADTaskAdopter.h"

@interface MKADOperation ()

/**
 超过2s没有接收到新的数据，超时
 */
@property (nonatomic, strong)dispatch_source_t receiveTimer;

/**
 线程ID
 */
@property (nonatomic, assign)mk_ad_taskOperationID operationID;

/**
 线程结束时候的回调
 */
@property (nonatomic, copy)void (^completeBlock) (NSError *error, id returnData);

@property (nonatomic, copy)void (^commandBlock)(void);

/**
 超时标志
 */
@property (nonatomic, assign)BOOL timeout;

/**
 接受数据超时个数
 */
@property (nonatomic, assign)NSInteger receiveTimerCount;

/// 分帧数据使用
@property (nonatomic, strong)NSMutableArray *dataList;

@end

@implementation MKADOperation
@synthesize executing = _executing;
@synthesize finished = _finished;

#pragma mark - life circle

- (void)dealloc{
    NSLog(@"MP任务销毁");
}

- (instancetype)initOperationWithID:(mk_ad_taskOperationID)operationID
                       commandBlock:(void (^)(void))commandBlock
                      completeBlock:(void (^)(NSError * _Nullable error, id _Nullable returnData))completeBlock {
    if (self = [super init]) {
        _executing = NO;
        _finished = NO;
        _completeBlock = completeBlock;
        _commandBlock = commandBlock;
        _operationID = operationID;
    }
    return self;
}

#pragma mark - super method

- (void)start{
    if (self.isFinished || self.isCancelled) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self startCommunication];
}

#pragma mark - MKBLEBaseOperationProtocol
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic {
    [self dataParserReceivedData:[MKADTaskAdopter parseReadDataWithCharacteristic:characteristic]];
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic {
    [self dataParserReceivedData:[MKADTaskAdopter parseWriteDataWithCharacteristic:characteristic]];
}

#pragma mark - Private method
- (void)startCommunication{
    if (self.isCancelled) {
        return;
    }
    if (self.commandBlock) {
        self.commandBlock();
    }
    [self startReceiveTimer];
}

/**
 如果需要从外设拿总条数，则在拿到总条数之后，开启接受超时定时器，开启定时器的时候已经设置了当前线程的生命周期，所以不需要重新beforeDate了。如果是直接开启的接收超时定时器，这个时候需要控制当前线程的生命周期
 
 */
- (void)startReceiveTimer{
    __weak __typeof(&*self)weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.receiveTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //当2s内没有接收到新的数据的时候，也认为是接受超时
    dispatch_source_set_timer(self.receiveTimer, dispatch_walltime(NULL, 0), 0.1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.receiveTimer, ^{
        __strong typeof(self) sself = weakSelf;
        if (sself.timeout || sself.receiveTimerCount >= 50) {
            //接受数据超时
            sself.receiveTimerCount = 0;
            [sself communicationTimeout];
            return ;
        }
        sself.receiveTimerCount ++;
    });
    if (self.isCancelled) {
        return;
    }
    //如果需要从外设拿总条数，则在拿到总条数之后，开启接受超时定时器
    dispatch_resume(self.receiveTimer);
}

- (void)finishOperation{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = NO;
    [self didChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    _finished = YES;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)communicationTimeout{
    self.timeout = YES;
    if (self.receiveTimer) {
        dispatch_cancel(self.receiveTimer);
    }
    [self finishOperation];
    if (self.completeBlock) {
        NSError *error = [[NSError alloc] initWithDomain:@"com.moko.operationError"
                                                    code:-999
                                                userInfo:@{@"errorInfo":@"Communication timeout"}];
        self.completeBlock(error, nil);
    }
}

- (void)dataParserReceivedData:(NSDictionary *)dataDic{
    if (self.isCancelled || !_executing || !MKValidDict(dataDic) || self.timeout) {
        return;
    }
    mk_ad_taskOperationID operationID = [dataDic[@"operationID"] integerValue];
    if (operationID == mk_ad_defaultTaskOperationID || operationID != self.operationID) {
        return;
    }
    NSDictionary *returnData = dataDic[@"returnData"];
    if (!MKValidDict(returnData)) {
        return;
    }
    //分帧数据
    NSString *totalNum = returnData[mk_ad_totalNumKey];
    if (MKValidStr(totalNum)) {
        //存在分帧数据
        self.receiveTimerCount = 0;
        NSData *data = returnData[mk_ad_contentKey];
        if (data) {
            [self.dataList addObject:data];
        }
        if (self.dataList.count == [totalNum integerValue]) {
            if (self.receiveTimer) {
                dispatch_cancel(self.receiveTimer);
            }
            [self finishOperation];
            if (self.completeBlock) {
                self.completeBlock(nil, self.dataList);
            }
        }
        return;
    }
    if (self.receiveTimer) {
        dispatch_cancel(self.receiveTimer);
    }
    [self finishOperation];
    if (self.completeBlock) {
        self.completeBlock(nil, returnData);
    }
}

#pragma mark - getter
- (BOOL)isConcurrent{
    return YES;
}

- (BOOL)isFinished{
    return _finished;
}

- (BOOL)isExecuting{
    return _executing;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
