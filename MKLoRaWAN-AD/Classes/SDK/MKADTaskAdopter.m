//
//  MKADTaskAdopter.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKADTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKADOperationID.h"
#import "MKADSDKDataAdopter.h"

NSString *const mk_ad_totalNumKey = @"mk_ad_totalNumKey";
NSString *const mk_ad_totalIndexKey = @"mk_ad_totalIndexKey";
NSString *const mk_ad_contentKey = @"mk_ad_contentKey";

@implementation MKADTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_ad_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_ad_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_ad_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_ad_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_ad_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 12) {
            state = [content substringWithRange:NSMakeRange(10, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_ad_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - 数据解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *headerString = [readString substringWithRange:NSMakeRange(0, 2)];
    if ([headerString isEqualToString:@"ee"]) {
        //分包协议
        return [self parsePacketData:readData];
    }
    if (![headerString isEqualToString:@"ed"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(8, 2)];
    if (readData.length != dataLen + 5) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 4)];
    NSString *content = [readString substringWithRange:NSMakeRange(10, dataLen * 2)];
    //不分包协议
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parsePacketData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 4)];
    if ([flag isEqualToString:@"00"]) {
        //读取
        NSString *totalNum = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(8, 2)];
        NSString *index = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(10, 2)];
        NSInteger len = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(12, 2)];
        if ([index integerValue] >= [totalNum integerValue]) {
            return @{};
        }
        mk_ad_taskOperationID operationID = mk_ad_defaultTaskOperationID;
        
        NSData *subData = [readData subdataWithRange:NSMakeRange(7, len)];
        NSDictionary *resultDic= @{
            mk_ad_totalNumKey:totalNum,
            mk_ad_totalIndexKey:index,
            mk_ad_contentKey:(subData ? subData : [NSData data]),
        };
        return [self dataParserGetDataSuccess:resultDic operationID:operationID];
    }
    if ([flag isEqualToString:@"01"]) {
        //配置
        mk_ad_taskOperationID operationID = mk_ad_defaultTaskOperationID;
        NSString *content = [readString substringWithRange:NSMakeRange(10, 2)];
        BOOL success = [content isEqualToString:@"01"];
        
        return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_ad_taskOperationID operationID = mk_ad_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"0015"]) {
        //读取MAC地址
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_ad_taskReadMacAddressOperation;
    }else if ([cmd isEqualToString:@"0016"]) {
        //读取霍尔关机功能
        BOOL lowPower = [content isEqualToString:@"01"];
        resultDic = @{
            @"lowPower":@(lowPower),
        };
        operationID = mk_ad_taskReadLowPowerStatusOperation;
    }else if ([cmd isEqualToString:@"0021"]) {
        //读取时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_ad_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"0022"]) {
        //读取设备心跳间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"0023"]) {
        //读取指示灯功能
        NSDictionary *indicatorSettings = [MKADSDKDataAdopter fetchIndicatorSettings:content];
        resultDic = @{
            @"indicatorSettings":indicatorSettings,
        };
        operationID = mk_ad_taskReadIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"0024"]) {
        //读取磁铁开机方式选择
        resultDic = @{
            @"method":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadMagnetTurnOnMethodOperation;
    }else if ([cmd isEqualToString:@"0025"]) {
        //读取霍尔关机功能
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_ad_taskReadHallPowerOffStatusOperation;
    }else if ([cmd isEqualToString:@"0026"]) {
        //读取关机信息上报
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_ad_taskReadShutdownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0040"]) {
        //读取电池电压
        resultDic = @{
            @"voltage":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadBatteryVoltageOperation;
    }else if ([cmd isEqualToString:@"0041"]) {
        //读取产测状态
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_ad_taskReadPCBAStatusOperation;
    }else if ([cmd isEqualToString:@"0042"]) {
        //读取自检故障原因
//        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":content,
        };
        operationID = mk_ad_taskReadSelftestStatusOperation;
    }else if ([cmd isEqualToString:@"0101"]) {
        //读取电池信息
        NSString *workTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 8)];
        NSString *advCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 8)];
        NSString *redLightTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(16, 8)];
        NSString *greenLightTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(24, 8)];
        NSString *blueLightTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(32, 8)];
        NSString *buzzerNormalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(40, 8)];
        NSString *buzzerAlarmTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(48, 8)];
        NSString *alarm1TriggerCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(56, 8)];
        NSString *alarm1PayloadCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(64, 8)];
        NSString *alarm2TriggerCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(72, 8)];
        NSString *alarm2PayloadCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(80, 8)];
        NSString *alarm3TriggerCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(88, 8)];
        NSString *alarm3PayloadCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(96, 8)];
        NSString *loraSendCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(104, 8)];
        NSString *loraPowerConsumption = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(112, 8)];
        NSString *batteryPower = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(120, 8)];
        
        resultDic = @{
            @"workTimes":workTimes,
            @"advCount":advCount,
            @"redLightTime":redLightTime,
            @"greenLightTime":greenLightTime,
            @"blueLightTime":blueLightTime,
            @"buzzerNormalTime":buzzerNormalTime,
            @"buzzerAlarmTime":buzzerAlarmTime,
            @"alarm1TriggerCount":alarm1TriggerCount,
            @"alarm1PayloadCount":alarm1PayloadCount,
            @"alarm2TriggerCount":alarm2TriggerCount,
            @"alarm2PayloadCount":alarm2PayloadCount,
            @"alarm3TriggerCount":alarm3TriggerCount,
            @"alarm3PayloadCount":alarm3PayloadCount,
            @"loraSendCount":loraSendCount,
            @"loraPowerConsumption":loraPowerConsumption,
            @"batteryPower":batteryPower
        };
        operationID = mk_ad_taskReadBatteryInformationOperation;
    }else if ([cmd isEqualToString:@"0102"]) {
        //读取上一周期电池电量消耗
        NSString *workTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 8)];
        NSString *advCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 8)];
        NSString *redLightTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(16, 8)];
        NSString *greenLightTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(24, 8)];
        NSString *blueLightTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(32, 8)];
        NSString *buzzerNormalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(40, 8)];
        NSString *buzzerAlarmTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(48, 8)];
        NSString *alarm1TriggerCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(56, 8)];
        NSString *alarm1PayloadCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(64, 8)];
        NSString *alarm2TriggerCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(72, 8)];
        NSString *alarm2PayloadCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(80, 8)];
        NSString *alarm3TriggerCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(88, 8)];
        NSString *alarm3PayloadCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(96, 8)];
        NSString *loraSendCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(104, 8)];
        NSString *loraPowerConsumption = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(112, 8)];
        NSString *batteryPower = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(120, 8)];
        
        resultDic = @{
            @"workTimes":workTimes,
            @"advCount":advCount,
            @"redLightTime":redLightTime,
            @"greenLightTime":greenLightTime,
            @"blueLightTime":blueLightTime,
            @"buzzerNormalTime":buzzerNormalTime,
            @"buzzerAlarmTime":buzzerAlarmTime,
            @"alarm1TriggerCount":alarm1TriggerCount,
            @"alarm1PayloadCount":alarm1PayloadCount,
            @"alarm2TriggerCount":alarm2TriggerCount,
            @"alarm2PayloadCount":alarm2PayloadCount,
            @"alarm3TriggerCount":alarm3TriggerCount,
            @"alarm3PayloadCount":alarm3PayloadCount,
            @"loraSendCount":loraSendCount,
            @"loraPowerConsumption":loraPowerConsumption,
            @"batteryPower":batteryPower
        };
        operationID = mk_ad_taskReadLastCycleBatteryInformationOperation;
    }else if ([cmd isEqualToString:@"0103"]) {
        //读取所有周期电池电量消耗
        NSString *workTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 8)];
        NSString *advCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 8)];
        NSString *redLightTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(16, 8)];
        NSString *greenLightTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(24, 8)];
        NSString *blueLightTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(32, 8)];
        NSString *buzzerNormalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(40, 8)];
        NSString *buzzerAlarmTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(48, 8)];
        NSString *alarm1TriggerCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(56, 8)];
        NSString *alarm1PayloadCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(64, 8)];
        NSString *alarm2TriggerCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(72, 8)];
        NSString *alarm2PayloadCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(80, 8)];
        NSString *alarm3TriggerCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(88, 8)];
        NSString *alarm3PayloadCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(96, 8)];
        NSString *loraSendCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(104, 8)];
        NSString *loraPowerConsumption = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(112, 8)];
        NSString *batteryPower = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(120, 8)];
        
        resultDic = @{
            @"workTimes":workTimes,
            @"advCount":advCount,
            @"redLightTime":redLightTime,
            @"greenLightTime":greenLightTime,
            @"blueLightTime":blueLightTime,
            @"buzzerNormalTime":buzzerNormalTime,
            @"buzzerAlarmTime":buzzerAlarmTime,
            @"alarm1TriggerCount":alarm1TriggerCount,
            @"alarm1PayloadCount":alarm1PayloadCount,
            @"alarm2TriggerCount":alarm2TriggerCount,
            @"alarm2PayloadCount":alarm2PayloadCount,
            @"alarm3TriggerCount":alarm3TriggerCount,
            @"alarm3PayloadCount":alarm3PayloadCount,
            @"loraSendCount":loraSendCount,
            @"loraPowerConsumption":loraPowerConsumption,
            @"batteryPower":batteryPower
        };
        operationID = mk_ad_taskReadAllCycleBatteryInformationOperation;
    }else if ([cmd isEqualToString:@"0105"]) {
        //读取电池消耗低电百分比
        resultDic = @{
            @"prompt":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"0106"]) {
        //读取低电触发心跳开关状态
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_ad_taskReadLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0107"]) {
        //读取低电状态下低电信息包上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLowPowerPayloadIntervalOperation;
    }else if ([cmd isEqualToString:@"010a"]) {
        //读取非报警状态低电判断条件:低电电压值
        resultDic = @{
            @"threshold":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLowPowerNonAlarmVoltageThresholdOperation;
    }else if ([cmd isEqualToString:@"010b"]) {
        //读取非报警状态低电判断条件:最小采样间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLowPowerNonAlarmMinSampleIntervalOperation;
    }else if ([cmd isEqualToString:@"010c"]) {
        //读取非报警状态低电判断条件:连续采样次数
        resultDic = @{
            @"times":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLowNonAlarmPowerSampleTimesOperation;
    }else if ([cmd isEqualToString:@"010d"]) {
        //读取报警状态低电判断条件:低电电压值
        resultDic = @{
            @"threshold":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLowPowerAlarmVoltageThresholdOperation;
    }else if ([cmd isEqualToString:@"010e"]) {
        //读取报警状态低电判断条件:最小采样间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLowPowerAlarmMinSampleIntervalOperation;
    }else if ([cmd isEqualToString:@"010f"]) {
        //读取报警状态低电判断条件:连续采样次数
        resultDic = @{
            @"times":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLowAlarmPowerSampleTimesOperation;
    }else if ([cmd isEqualToString:@"0200"]) {
        //读取密码开关
        BOOL need = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"need":@(need)
        };
        operationID = mk_ad_taskReadConnectationNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"0201"]) {
        //读取密码
        NSData *passwordData = [data subdataWithRange:NSMakeRange(5, data.length - 5)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_ad_taskReadPasswordOperation;
    }else if ([cmd isEqualToString:@"0202"]) {
        //读取广播超时时长
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"0203"]) {
        //读取Beacon模式开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ad_taskReadBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0204"]) {
        //读取广播间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"0205"]) {
        //读取设备Tx Power
        NSString *txPower = [MKADSDKDataAdopter fetchTxPowerValueString:content];
        resultDic = @{@"txPower":txPower};
        operationID = mk_ad_taskReadTxPowerOperation;
    }else if ([cmd isEqualToString:@"0206"]) {
        //读取设备广播名称
        NSData *nameData = [data subdataWithRange:NSMakeRange(5, data.length - 5)];
        NSString *deviceName = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
        operationID = mk_ad_taskReadDeviceNameOperation;
    }else if ([cmd isEqualToString:@"0500"]) {
        //读取LoRaWAN网络状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLorawanNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"0501"]) {
        //读取LoRaWAN频段
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLorawanRegionOperation;
    }else if ([cmd isEqualToString:@"0502"]) {
        //读取LoRaWAN入网类型
        resultDic = @{
            @"modem":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLorawanModemOperation;
    }else if ([cmd isEqualToString:@"0503"]) {
        //读取LoRaWAN DEVEUI
        resultDic = @{
            @"devEUI":content,
        };
        operationID = mk_ad_taskReadLorawanDEVEUIOperation;
    }else if ([cmd isEqualToString:@"0504"]) {
        //读取LoRaWAN APPEUI
        resultDic = @{
            @"appEUI":content
        };
        operationID = mk_ad_taskReadLorawanAPPEUIOperation;
    }else if ([cmd isEqualToString:@"0505"]) {
        //读取LoRaWAN APPKEY
        resultDic = @{
            @"appKey":content
        };
        operationID = mk_ad_taskReadLorawanAPPKEYOperation;
    }else if ([cmd isEqualToString:@"0506"]) {
        //读取LoRaWAN DEVADDR
        resultDic = @{
            @"devAddr":content
        };
        operationID = mk_ad_taskReadLorawanDEVADDROperation;
    }else if ([cmd isEqualToString:@"0507"]) {
        //读取LoRaWAN APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_ad_taskReadLorawanAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"0508"]) {
        //读取LoRaWAN nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_ad_taskReadLorawanNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"050a"]) {
        //读取ADR_ACK_LIMIT
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"050b"]) {
        //读取ADR_ACK_DELAY
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"0520"]) {
        //读取LoRaWAN CH
        resultDic = @{
            @"CHL":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"CHH":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)]
        };
        operationID = mk_ad_taskReadLorawanCHOperation;
    }else if ([cmd isEqualToString:@"0521"]) {
        //读取LoRaWAN DR
        resultDic = @{
            @"DR":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLorawanDROperation;
    }else if ([cmd isEqualToString:@"0522"]) {
        //读取LoRaWAN 数据发送策略
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *transmissions = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *DRL = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        NSString *DRH = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"transmissions":transmissions,
            @"DRL":DRL,
            @"DRH":DRH,
        };
        operationID = mk_ad_taskReadLorawanUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"0523"]) {
        //读取LoRaWAN duty cycle
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ad_taskReadLorawanDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"0540"]) {
        //读取LoRaWAN devtime指令同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLorawanDevTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"0541"]) {
        //读取LoRaWAN LinkCheckReq指令间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadLorawanNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"0551"]) {
        //读取心跳数据包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ad_taskReadHeartbeatPayloadDataOperation;
    }else if ([cmd isEqualToString:@"0552"]) {
        //读取低电包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ad_taskReadLowPowerPayloadDataOperation;
    }else if ([cmd isEqualToString:@"0554"]) {
        //读取事件信息包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ad_taskReadEventPayloadDataOperation;
    }else if ([cmd isEqualToString:@"055e"]) {
        //读取报警信息包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ad_taskReadAlarmPayloadDataOperation;
    }else if ([cmd isEqualToString:@"0600"]) {
        //读取事件类型1开关状态
        resultDic = @{
            @"isOn":@(([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"])),
            @"exit":@(([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"])),
        };
        operationID = mk_ad_taskReadAlarm1FunctionSwitchOperation;
    }else if ([cmd isEqualToString:@"0601"]) {
        //读取事件类型1蜂鸣器类型
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadBuzzerTypeAlarm1TriggerOperation;
    }else if ([cmd isEqualToString:@"0602"]) {
        //读取时间类型1解除报警按键时长
        resultDic = @{
            @"time":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadAlarm1ExitLongPressTimeOperation;
    }else if ([cmd isEqualToString:@"0603"]) {
        //读取时间类型1上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadAlarm1ReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0610"]) {
        //读取事件类型2开关状态
        resultDic = @{
            @"isOn":@(([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"])),
            @"exit":@(([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"])),
        };
        operationID = mk_ad_taskReadAlarm2FunctionSwitchOperation;
    }else if ([cmd isEqualToString:@"0611"]) {
        //读取事件类型2蜂鸣器类型
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadBuzzerTypeAlarm2TriggerOperation;
    }else if ([cmd isEqualToString:@"0612"]) {
        //读取时间类型2解除报警按键时长
        resultDic = @{
            @"time":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadAlarm2ExitLongPressTimeOperation;
    }else if ([cmd isEqualToString:@"0613"]) {
        //读取时间类型2上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadAlarm2ReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0620"]) {
        //读取事件类型3开关状态
        resultDic = @{
            @"isOn":@(([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"])),
            @"exit":@(([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"])),
        };
        operationID = mk_ad_taskReadAlarm3FunctionSwitchOperation;
    }else if ([cmd isEqualToString:@"0621"]) {
        //读取事件类型3蜂鸣器类型
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadBuzzerTypeAlarm3TriggerOperation;
    }else if ([cmd isEqualToString:@"0622"]) {
        //读取时间类型3解除报警按键时长
        resultDic = @{
            @"time":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadAlarm3ExitLongPressTimeOperation;
    }else if ([cmd isEqualToString:@"0623"]) {
        //读取时间类型3上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ad_taskReadAlarm3ReportIntervalOperation;
    }
    
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_ad_taskOperationID operationID = mk_ad_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    
    if ([cmd isEqualToString:@"01"]) {
        //
    }else if ([cmd isEqualToString:@"0000"]) {
        //关机
        operationID = mk_ad_taskPowerOffOperation;
    }else if ([cmd isEqualToString:@"0001"]) {
        //配置LoRaWAN 入网
        operationID = mk_ad_taskRestartDeviceOperation;
    }else if ([cmd isEqualToString:@"0002"]) {
        //恢复出厂设置
        operationID = mk_ad_taskFactoryResetOperation;
    }else if ([cmd isEqualToString:@"0020"]) {
        //配置时间戳
        operationID = mk_ad_taskConfigDeviceTimeOperation;
    }else if ([cmd isEqualToString:@"0021"]) {
        //配置时区
        operationID = mk_ad_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"0022"]) {
        //配置设备心跳间隔
        operationID = mk_ad_taskConfigHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"0023"]) {
        //配置指示灯开关状态
        operationID = mk_ad_taskConfigIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"0024"]) {
        //配置磁铁开机方式选择
        operationID = mk_ad_taskConfigMagnetTurnOnMethodOperation;
    }else if ([cmd isEqualToString:@"0025"]) {
        //配置霍尔关机功能
        operationID = mk_ad_taskConfigHallPowerOffStatusOperation;
    }else if ([cmd isEqualToString:@"0026"]) {
        //配置关机信息上报状态
        operationID = mk_ad_taskConfigShutdownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0100"]) {
        //清除电池电量数据
        operationID = mk_ad_taskBatteryResetOperation;
    }else if ([cmd isEqualToString:@"0105"]) {
        //配置低电百分比
        operationID = mk_ad_taskConfigLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"0106"]) {
        //配置低电触发心跳开关状态
        operationID = mk_ad_taskConfigLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0107"]) {
        //配置低电状态下低电信息包上报间隔
        operationID = mk_ad_taskConfigLowPowerPayloadIntervalOperation;
    }else if ([cmd isEqualToString:@"010a"]) {
        //配置非报警状态低电判断条件:低电电压值
        operationID = mk_ad_taskConfigLowPowerNonAlarmVoltageThresholdOperation;
    }else if ([cmd isEqualToString:@"010b"]) {
        //配置非报警状态低电判断条件:最小采样间隔
        operationID = mk_ad_taskConfigLowPowerNonAlarmMinSampleIntervalOperation;
    }else if ([cmd isEqualToString:@"010c"]) {
        //配置非报警状态低电判断条件:连续采样次数
        operationID = mk_ad_taskConfigLowPowerNonAlarmSampleTimesOperation;
    }else if ([cmd isEqualToString:@"010d"]) {
        //配置报警状态低电判断条件:低电电压值
        operationID = mk_ad_taskConfigLowPowerAlarmVoltageThresholdOperation;
    }else if ([cmd isEqualToString:@"010e"]) {
        //配置报警状态低电判断条件:最小采样间隔
        operationID = mk_ad_taskConfigLowPowerAlarmMinSampleIntervalOperation;
    }else if ([cmd isEqualToString:@"010f"]) {
        //配置报警状态低电判断条件:连续采样次数
        operationID = mk_ad_taskConfigLowPowerAlarmSampleTimesOperation;
    }else if ([cmd isEqualToString:@"0200"]) {
        //配置是否需要连接密码
        operationID = mk_ad_taskConfigNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"0201"]) {
        //配置连接密码
        operationID = mk_ad_taskConfigPasswordOperation;
    }else if ([cmd isEqualToString:@"0202"]) {
        //配置蓝牙广播超时时间
        operationID = mk_ad_taskConfigBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"0203"]) {
        //配置Beacon模式开关
        operationID = mk_ad_taskConfigBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0204"]) {
        //配置广播间隔
        operationID = mk_ad_taskConfigAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"0205"]) {
        //配置蓝牙TX Power
        operationID = mk_ad_taskConfigTxPowerOperation;
    }else if ([cmd isEqualToString:@"0206"]) {
        //配置蓝牙广播名称
        operationID = mk_ad_taskConfigDeviceNameOperation;
    }else if ([cmd isEqualToString:@"0501"]) {
        //配置LoRaWAN频段
        operationID = mk_ad_taskConfigRegionOperation;
    }else if ([cmd isEqualToString:@"0502"]) {
        //配置LoRaWAN入网类型
        operationID = mk_ad_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"0503"]) {
        //配置LoRaWAN DEVEUI
        operationID = mk_ad_taskConfigDEVEUIOperation;
    }else if ([cmd isEqualToString:@"0504"]) {
        //配置LoRaWAN APPEUI
        operationID = mk_ad_taskConfigAPPEUIOperation;
    }else if ([cmd isEqualToString:@"0505"]) {
        //配置LoRaWAN APPKEY
        operationID = mk_ad_taskConfigAPPKEYOperation;
    }else if ([cmd isEqualToString:@"0506"]) {
        //配置LoRaWAN DEVADDR
        operationID = mk_ad_taskConfigDEVADDROperation;
    }else if ([cmd isEqualToString:@"0507"]) {
        //配置LoRaWAN APPSKEY
        operationID = mk_ad_taskConfigAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"0508"]) {
        //配置LoRaWAN nwkSkey
        operationID = mk_ad_taskConfigNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"050a"]) {
        //配置ADR_ACK_LIMIT
        operationID = mk_ad_taskConfigLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"050b"]) {
        //配置ADR_ACK_DELAY
        operationID = mk_ad_taskConfigLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"0520"]) {
        //配置LoRaWAN CH
        operationID = mk_ad_taskConfigCHValueOperation;
    }else if ([cmd isEqualToString:@"0521"]) {
        //配置LoRaWAN DR
        operationID = mk_ad_taskConfigDRValueOperation;
    }else if ([cmd isEqualToString:@"0522"]) {
        //配置LoRaWAN 数据发送策略
        operationID = mk_ad_taskConfigUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"0523"]) {
        //配置LoRaWAN duty cycle
        operationID = mk_ad_taskConfigDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"0540"]) {
        //配置LoRaWAN devtime指令同步间隔
        operationID = mk_ad_taskConfigTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"0541"]) {
        //配置LoRaWAN LinkCheckReq指令间隔
        operationID = mk_ad_taskConfigNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"0551"]) {
        //配置心跳包上行配置
        operationID = mk_ad_taskConfigHeartbeatPayloadOperation;
    }else if ([cmd isEqualToString:@"0552"]) {
        //配置低电包上行配置
        operationID = mk_ad_taskConfigLowPowerPayloadOperation;
    }else if ([cmd isEqualToString:@"0554"]) {
        //配置事件信息包上行配置
        operationID = mk_ad_taskConfigEventPayloadWithMessageTypeOperation;
    }else if ([cmd isEqualToString:@"055e"]) {
        //配置报警信息包上行配置
        operationID = mk_ad_taskConfigAlarmPayloadWithMessageTypeOperation;
    }else if ([cmd isEqualToString:@"0600"]) {
        //配置事件类型1开关状态
        operationID = mk_ad_taskConfigAlarm1FunctionSwitchOperation;
    }else if ([cmd isEqualToString:@"0601"]) {
        //配置事件类型1蜂鸣器类型
        operationID = mk_ad_taskConfigBuzzerTypeAlarm1TriggerOperation;
    }else if ([cmd isEqualToString:@"0602"]) {
        //配置事件类型1解除报警按键时长
        operationID = mk_ad_taskConfigAlarm1ExitLongPressTimeOperation;
    }else if ([cmd isEqualToString:@"0603"]) {
        //配置事件类型1上报间隔
        operationID = mk_ad_taskConfigAlarm1ReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0610"]) {
        //配置事件类型2开关状态
        operationID = mk_ad_taskConfigAlarm2FunctionSwitchOperation;
    }else if ([cmd isEqualToString:@"0611"]) {
        //配置事件类型2蜂鸣器类型
        operationID = mk_ad_taskConfigBuzzerTypeAlarm2TriggerOperation;
    }else if ([cmd isEqualToString:@"0612"]) {
        //配置事件类型2解除报警按键时长
        operationID = mk_ad_taskConfigAlarm2ExitLongPressTimeOperation;
    }else if ([cmd isEqualToString:@"0613"]) {
        //配置事件类型2上报间隔
        operationID = mk_ad_taskConfigAlarm2ReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0620"]) {
        //配置事件类型3开关状态
        operationID = mk_ad_taskConfigAlarm3FunctionSwitchOperation;
    }else if ([cmd isEqualToString:@"0621"]) {
        //配置事件类型3蜂鸣器类型
        operationID = mk_ad_taskConfigBuzzerTypeAlarm3TriggerOperation;
    }else if ([cmd isEqualToString:@"0622"]) {
        //配置事件类型3解除报警按键时长
        operationID = mk_ad_taskConfigAlarm3ExitLongPressTimeOperation;
    }else if ([cmd isEqualToString:@"0623"]) {
        //配置事件类型3上报间隔
        operationID = mk_ad_taskConfigAlarm3ReportIntervalOperation;
    }
    
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}



#pragma mark -

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_ad_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
