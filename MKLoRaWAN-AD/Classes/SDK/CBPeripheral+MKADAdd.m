//
//  CBPeripheral+MKADAdd.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKADAdd.h"

#import <objc/runtime.h>

static const char *ad_manufacturerKey = "ad_manufacturerKey";
static const char *ad_seriesNumberKey = "ad_seriesNumberKey";
static const char *ad_deviceModelKey = "ad_deviceModelKey";
static const char *ad_hardwareKey = "ad_hardwareKey";
static const char *ad_softwareKey = "ad_softwareKey";
static const char *ad_firmwareKey = "ad_firmwareKey";

static const char *ad_passwordKey = "ad_passwordKey";
static const char *ad_disconnectTypeKey = "ad_disconnectTypeKey";
static const char *ad_customKey = "ad_customKey";
static const char *ad_logKey = "ad_logKey";

static const char *ad_passwordNotifySuccessKey = "ad_passwordNotifySuccessKey";
static const char *ad_disconnectTypeNotifySuccessKey = "ad_disconnectTypeNotifySuccessKey";
static const char *ad_customNotifySuccessKey = "ad_customNotifySuccessKey";

@implementation CBPeripheral (MKADAdd)

- (void)ad_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &ad_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A25"]]) {
                objc_setAssociatedObject(self, &ad_seriesNumberKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &ad_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &ad_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &ad_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &ad_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &ad_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &ad_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
                objc_setAssociatedObject(self, &ad_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
                objc_setAssociatedObject(self, &ad_logKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
}

- (void)ad_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &ad_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &ad_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        objc_setAssociatedObject(self, &ad_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)ad_connectSuccess {
    if (![objc_getAssociatedObject(self, &ad_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &ad_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &ad_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.ad_manufacturer || !self.ad_deviceModel || !self.ad_hardware || !self.ad_software || !self.ad_firmware) {
        return NO;
    }
    if (!self.ad_password || !self.ad_disconnectType || !self.ad_custom || !self.ad_log) {
        return NO;
    }
    return YES;
}

- (void)ad_setNil {
    objc_setAssociatedObject(self, &ad_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ad_seriesNumberKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ad_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ad_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ad_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ad_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &ad_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ad_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ad_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ad_logKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &ad_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ad_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ad_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)ad_manufacturer {
    return objc_getAssociatedObject(self, &ad_manufacturerKey);
}

- (CBCharacteristic *)ad_seriesNumber {
    return objc_getAssociatedObject(self, &ad_seriesNumberKey);
}

- (CBCharacteristic *)ad_deviceModel {
    return objc_getAssociatedObject(self, &ad_deviceModelKey);
}

- (CBCharacteristic *)ad_hardware {
    return objc_getAssociatedObject(self, &ad_hardwareKey);
}

- (CBCharacteristic *)ad_software {
    return objc_getAssociatedObject(self, &ad_softwareKey);
}

- (CBCharacteristic *)ad_firmware {
    return objc_getAssociatedObject(self, &ad_firmwareKey);
}

- (CBCharacteristic *)ad_password {
    return objc_getAssociatedObject(self, &ad_passwordKey);
}

- (CBCharacteristic *)ad_disconnectType {
    return objc_getAssociatedObject(self, &ad_disconnectTypeKey);
}

- (CBCharacteristic *)ad_custom {
    return objc_getAssociatedObject(self, &ad_customKey);
}

- (CBCharacteristic *)ad_log {
    return objc_getAssociatedObject(self, &ad_logKey);
}

@end
