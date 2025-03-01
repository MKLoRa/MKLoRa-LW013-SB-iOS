//
//  MKADLoRaSettingModel.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKADLoRaSettingModel.h"

#import "MKMacroDefines.h"

#import "MKADInterface.h"
#import "MKADInterface+MKADConfig.h"

@interface MKADLoRaSettingModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKADLoRaSettingModel

- (instancetype)init {
    if (self = [super init]) {
        self.needAdvanceSetting = YES;
        self.modem = 1;
    }
    return self;
}

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readModem]) {
            [self operationFailedBlockWithMsg:@"Read Modem Error" block:failedBlock];
            return;
        }
        if (![self readRegion]) {
            [self operationFailedBlockWithMsg:@"Read Region Error" block:failedBlock];
            return;
        }
        if (![self readDevEUI]) {
            [self operationFailedBlockWithMsg:@"Read DevEUI Error" block:failedBlock];
            return;
        }
        if (![self readAppEUI]) {
            [self operationFailedBlockWithMsg:@"Read AppEUI Error" block:failedBlock];
            return;
        }
        if (![self readAppKey]) {
            [self operationFailedBlockWithMsg:@"Read AppKey Error" block:failedBlock];
            return;
        }
        if (![self readDevAddr]) {
            [self operationFailedBlockWithMsg:@"Read Region Error" block:failedBlock];
            return;
        }
        if (![self readAppSkey]) {
            [self operationFailedBlockWithMsg:@"Read AppSKEY Error" block:failedBlock];
            return;
        }
        if (![self readNwkSkey]) {
            [self operationFailedBlockWithMsg:@"Read NWKSKEY Error" block:failedBlock];
            return;
        }
        if (!self.needAdvanceSetting) {
            moko_dispatch_main_safe(^{
                if (sucBlock) {
                    sucBlock();
                }
            });
            return;
        }
        if (self.region == 1 || self.region == 5) {
            //US915、AU915
            if (![self readCHValue]) {
                [self operationFailedBlockWithMsg:@"Read CH Error" block:failedBlock];
                return;
            }
        }
        //Duty-cycle
        if (self.region == 2 || self.region == 6) {
            //EU868,RU864
            if (![self readDutyStatus]) {
                [self operationFailedBlockWithMsg:@"Read Duty Cycle Error" block:failedBlock];
                return;
            }
        }
        if (self.region == 2 || self.region == 3
            || self.region == 4 || self.region == 6) {
            //EU868,KR920, IN865, RU864
            if (![self readJoinValue]) {
                [self operationFailedBlockWithMsg:@"Read Dr For Join Error" block:failedBlock];
                return;
            }
        }
        if (![self readUplinkStrategy]) {
            [self operationFailedBlockWithMsg:@"Read Uplink  Strategy Error" block:failedBlock];
            return;
        }
        if (![self readACKLimit]) {
            [self operationFailedBlockWithMsg:@"Read ADR ACK LIMIT Error" block:failedBlock];
            return;
        }
        if (![self readACKDelay]) {
            [self operationFailedBlockWithMsg:@"Read ADR ACK DELAY Error" block:failedBlock];
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
        if (![self checkParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configModem]) {
            [self operationFailedBlockWithMsg:@"Config Modem Error" block:failedBlock];
            return;
        }
        if (![self configRegion]) {
            [self operationFailedBlockWithMsg:@"Config Region Error" block:failedBlock];
            return;
        }
        if (![self configDevEUI]) {
            [self operationFailedBlockWithMsg:@"Config DevEUI Error" block:failedBlock];
            return;
        }
        if (![self configAppEUI]) {
            [self operationFailedBlockWithMsg:@"Config AppEUI Error" block:failedBlock];
            return;
        }
        if (self.modem == 1) {
            //ABP
            if (![self configDevAddr]) {
                [self operationFailedBlockWithMsg:@"Config Region Error" block:failedBlock];
                return;
            }
            if (![self configAppSkey]) {
                [self operationFailedBlockWithMsg:@"Config AppSKEY Error" block:failedBlock];
                return;
            }
            if (![self configNwkSkey]) {
                [self operationFailedBlockWithMsg:@"Config NWKSKEY Error" block:failedBlock];
                return;
            }
        }else if (self.modem == 2) {
            //OTAA
            if (![self configAppKey]) {
                [self operationFailedBlockWithMsg:@"Config AppKey Error" block:failedBlock];
                return;
            }
        }
        
        if (!self.needAdvanceSetting) {
            if (![self restartDevice]) {
                [self operationFailedBlockWithMsg:@"Connect network error" block:failedBlock];
                return;
            }
            moko_dispatch_main_safe(^{
                if (sucBlock) {
                    sucBlock();
                }
            });
            return;
        }
        if (self.region == 1 || self.region == 5) {
            //AU915、US915
            if (![self configCHValue]) {
                [self operationFailedBlockWithMsg:@"Config CH Error" block:failedBlock];
                return;
            }
        }
        if (self.region == 2 || self.region == 6) {
            //EU868,RU864
            if (![self configDutyStatus]) {
                [self operationFailedBlockWithMsg:@"Config Duty Cycle Error" block:failedBlock];
                return;
            }
        }
        
        if (self.region == 2 || self.region == 3
            || self.region == 4 || self.region == 6) {
            //EU868,KR920, IN865, RU864
            if (![self configJoinValue]) {
                [self operationFailedBlockWithMsg:@"Config DR For Join Error" block:failedBlock];
                return;
            }
        }
        if (![self configUplinkStrategy]) {
            [self operationFailedBlockWithMsg:@"Config Uplink  Strategy Error" block:failedBlock];
            return;
        }
        if (![self configACKLimit]) {
            [self operationFailedBlockWithMsg:@"Config ADR ACK LIMIT Error" block:failedBlock];
            return;
        }
        if (![self configACKDelay]) {
            [self operationFailedBlockWithMsg:@"Config ADR ACK DELAY Error" block:failedBlock];
            return;
        }
        if (![self restartDevice]) {
            [self operationFailedBlockWithMsg:@"Connect network error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - public method
- (void)configAdvanceSettingDefaultParams {
    self.CHL = 0;
    if (self.region == 1 || self.region == 5) {
        //AU915、US915
        self.CHL = 8;
        self.CHH = 15;
    }else if (self.region == 2 || self.region == 3 || self.region == 4) {
        //EU868、KR920、IN865
        self.CHH = 2;
    }else if (self.region == 0 || self.region == 6 || self.region == 7
              || self.region == 8 || self.region == 9 || self.region == 10) {
        //AS923、RU864、AS923-1、AS923-2、AS923-3、AS923-4
        self.CHH = 1;
    }
    self.dutyIsOn = NO;
    
    self.adrIsOn = YES;
    if (self.region == 0 || self.region == 1 || self.region == 7
        || self.region == 8 || self.region == 9 || self.region == 10) {
        //AS923、AU915、AS923-1、AS923-2、AS923-3、AS923-4
        self.join = 2;
        self.DRL = 2;
        self.DRH = 2;
    }else {
        self.join = 0;
        self.DRL = 0;
        self.DRH = 0;
    }
}

- (NSArray <NSString *>*)CHLValueList {
    if (self.region == 1 || self.region == 5) {
        //AU915、US915
        return [self loadStringWithMaxValue:63];
    }
    if (self.region == 2 || self.region == 3 || self.region == 4) {
        //EU868、KR920、IN865
        return [self loadStringWithMaxValue:2];
    }
    //RU864、AS923
    return [self loadStringWithMaxValue:1];
}

- (NSArray <NSString *>*)CHHValueList {
    NSArray *chlList = [self CHLValueList];
    return [chlList subarrayWithRange:NSMakeRange(self.CHL, chlList.count - self.CHL)];
}

- (NSArray <NSString *>*)DRValueList; {
    if (self.region == 0 || self.region == 7
        || self.region == 8 || self.region == 9 || self.region == 10) {
        //AS923、AS923-1、AS923-2、AS923-3、AS923-4
        return @[@"2",@"3",@"4",@"5"];
    }
    if (self.region == 1) {
        //AU915
        return @[@"2",@"3",@"4",@"5",@"6"];
    }
    if (self.region == 5) {
        //US915
        return [self loadStringWithMaxValue:4];
    }
    return [self loadStringWithMaxValue:5];
}

- (NSArray <NSString *>*)DRLValueList {
    return [self DRValueList];
}

- (NSArray <NSString *>*)DRHValueList {
    NSArray *drlList = [self DRLValueList];
    NSInteger lowIndex = 0;
    for (NSInteger i = 0; i < drlList.count; i ++) {
        if (self.DRL == [drlList[i] integerValue]) {
            lowIndex = i;
            break;
        }
    }

    return [drlList subarrayWithRange:NSMakeRange(lowIndex, drlList.count - lowIndex)];
}

#pragma mark - interface
- (BOOL)readModem {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanModemWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.modem = [returnData[@"result"][@"modem"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configModem {
    __block BOOL success = NO;
    [MKADInterface ad_configModem:(self.modem - 1) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRegion {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanRegionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger region = [returnData[@"result"][@"region"] integerValue];
        self.region = [self exchangeRegion:region];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRegion {
    __block BOOL success = NO;
    [MKADInterface ad_configRegion:self.region sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDevEUI {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanDEVEUIWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.devEUI = returnData[@"result"][@"devEUI"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDevEUI {
    __block BOOL success = NO;
    [MKADInterface ad_configDEVEUI:self.devEUI sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAppEUI {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanAPPEUIWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.appEUI = returnData[@"result"][@"appEUI"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAppEUI {
    __block BOOL success = NO;
    [MKADInterface ad_configAPPEUI:self.appEUI sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAppKey {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanAPPKEYWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.appKey = returnData[@"result"][@"appKey"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAppKey {
    __block BOOL success = NO;
    [MKADInterface ad_configAPPKEY:self.appKey sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDevAddr {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanDEVADDRWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.devAddr = returnData[@"result"][@"devAddr"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDevAddr {
    __block BOOL success = NO;
    [MKADInterface ad_configDEVADDR:self.devAddr sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAppSkey {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanAPPSKEYWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.appSKey = returnData[@"result"][@"appSkey"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAppSkey {
    __block BOOL success = NO;
    [MKADInterface ad_configAPPSKEY:self.appSKey sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNwkSkey {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanNWKSKEYWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.nwkSKey = returnData[@"result"][@"nwkSkey"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNwkSkey {
    __block BOOL success = NO;
    [MKADInterface ad_configNWKSKEY:self.nwkSKey sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readCHValue {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanCHWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.CHL = [returnData[@"result"][@"CHL"] integerValue];
        self.CHH = [returnData[@"result"][@"CHH"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCHValue {
    __block BOOL success = NO;
    [MKADInterface ad_configCHL:self.CHL CHH:self.CHH sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDutyStatus {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanDutyCycleStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.dutyIsOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDutyStatus {
    __block BOOL success = NO;
    [MKADInterface ad_configDutyCycleStatus:self.dutyIsOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readJoinValue {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanDRWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.join = [returnData[@"result"][@"DR"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configJoinValue {
    __block BOOL success = NO;
    [MKADInterface ad_configDR:self.join sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readUplinkStrategy {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanUplinkStrategyWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.adrIsOn = [returnData[@"result"][@"isOn"] boolValue];
        self.DRL =  [returnData[@"result"][@"DRL"] integerValue];
        self.DRH = [returnData[@"result"][@"DRH"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configUplinkStrategy {
    __block BOOL success = NO;
    [MKADInterface ad_configUplinkStrategy:self.adrIsOn transmissions:1 DRL:self.DRL DRH:self.DRH sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readACKLimit {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanADRACKLimitWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.ackLimit = returnData[@"result"][@"value"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configACKLimit {
    __block BOOL success = NO;
    [MKADInterface ad_configLorawanADRACKLimit:[self.ackLimit integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readACKDelay {
    __block BOOL success = NO;
    [MKADInterface ad_readLorawanADRACKDelayWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.ackDelay = returnData[@"result"][@"value"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configACKDelay {
    __block BOOL success = NO;
    [MKADInterface ad_configLorawanADRACKDelay:[self.ackDelay integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)restartDevice {
    __block BOOL success = NO;
    [MKADInterface ad_restartDeviceWithSucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"loraParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)checkParams {
    //0:ABP,1:OTAA
    if (self.modem != 1 && self.modem != 2) {
        return NO;
    }
    if (!ValidStr(self.devEUI) || self.devEUI.length != 16) {
        return NO;
    }
    if (!ValidStr(self.appEUI) || self.appEUI.length != 16) {
        return NO;
    }
    if (self.modem == 1) {
        //ABP
        if (!ValidStr(self.devAddr) || self.devAddr.length != 8) {
            return NO;
        }
        if (!ValidStr(self.nwkSKey) || self.nwkSKey.length != 32) {
            return NO;
        }
        if (!ValidStr(self.appSKey) || self.appSKey.length != 32) {
            return NO;
        }
    }else {
        //OTAA
        if (!ValidStr(self.appKey) || self.appKey.length != 32) {
            return NO;
        }
    }
    if (self.region < 0 || self.region > 10) {
        return NO;
    }

    if (self.needAdvanceSetting) {
        if (self.region == 1 || self.region == 5) {
            if (self.CHL < 0 || self.CHL > 95 || self.CHH < self.CHL || self.CHH > 95) {
                return NO;
            }
        }
        if (self.region == 0 || self.region == 2 || self.region == 3 || self.region == 4
            || self.region == 7
            || self.region == 8 || self.region == 9 || self.region == 10) {
            //EU868,KR920, IN865, RU864、AS923-1、AS923-2、AS923-3、AS923-4
            if (self.join < 0 || self.join > 5) {
                return NO;
            }
        }
        if (self.DRL < 0 || self.DRL > 6 || self.DRH < self.DRL || self.DRH > 6) {
            return NO;
        }
        if (!ValidStr(self.ackLimit) || [self.ackLimit integerValue] < 1 || [self.ackLimit integerValue] > 255) {
            return NO;
        }if (!ValidStr(self.ackDelay) || [self.ackDelay integerValue] < 1 || [self.ackDelay integerValue] > 255) {
            return NO;
        }
    }
    return YES;
}

- (NSArray *)loadStringWithMaxValue:(NSInteger)max {
    NSMutableArray *list = [NSMutableArray array];
    for (NSInteger i = 0; i <= max; i ++) {
        [list addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    return list;
}

- (NSInteger)exchangeRegion:(NSInteger)region {
    if (region == 0 || region == 1) {
        return region;
    }
    return (region - 3);
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
        _readQueue = dispatch_queue_create("loraParamsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
