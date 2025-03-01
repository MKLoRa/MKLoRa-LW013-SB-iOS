//
//  CBPeripheral+MKADAdd.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKADAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ad_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ad_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ad_seriesNumber;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ad_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ad_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ad_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *ad_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *ad_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *ad_custom;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *ad_log;

- (void)ad_updateCharacterWithService:(CBService *)service;

- (void)ad_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)ad_connectSuccess;

- (void)ad_setNil;

@end

NS_ASSUME_NONNULL_END
