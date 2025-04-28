//
//  MKADInterface.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKADInterface.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKADCentralManager.h"
#import "MKADOperationID.h"
#import "MKADOperation.h"
#import "CBPeripheral+MKADAdd.h"
#import "MKADSDKDataAdopter.h"

#define centralManager [MKADCentralManager shared]
#define peripheral ([MKADCentralManager shared].peripheral)

@implementation MKADInterface

#pragma mark ****************************************Device Service Information************************************************

+ (void)ad_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ad_taskReadDeviceModelOperation
                           characteristic:peripheral.ad_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ad_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ad_taskReadFirmwareOperation
                           characteristic:peripheral.ad_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ad_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ad_taskReadHardwareOperation
                           characteristic:peripheral.ad_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ad_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ad_taskReadSoftwareOperation
                           characteristic:peripheral.ad_software
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ad_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ad_taskReadManufacturerOperation
                           characteristic:peripheral.ad_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark ****************************************System************************************************

+ (void)ad_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadMacAddressOperation
                     cmdFlag:@"0015"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowPowerStatusOperation
                     cmdFlag:@"0016"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadTimeZoneOperation
                     cmdFlag:@"0021"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadHeartbeatIntervalOperation
                     cmdFlag:@"0022"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadIndicatorSettingsOperation
                     cmdFlag:@"0023"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readMagnetTurnOnMethodWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadMagnetTurnOnMethodOperation
                     cmdFlag:@"0024"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readHallPowerOffStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadHallPowerOffStatusOperation
                     cmdFlag:@"0025"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readShutdownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadShutdownPayloadStatusOperation
                     cmdFlag:@"0026"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadBatteryVoltageOperation
                     cmdFlag:@"0040"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadPCBAStatusOperation
                     cmdFlag:@"0041"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadSelftestStatusOperation
                     cmdFlag:@"0042"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** Battery ************************************************

+ (void)ad_readBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadBatteryInformationOperation
                     cmdFlag:@"0101"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLastCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLastCycleBatteryInformationOperation
                     cmdFlag:@"0102"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readAllCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadAllCycleBatteryInformationOperation
                     cmdFlag:@"0103"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowPowerPromptOperation
                     cmdFlag:@"0105"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowPowerPayloadStatusOperation
                     cmdFlag:@"0106"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerPayloadIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowPowerPayloadIntervalOperation
                     cmdFlag:@"0107"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerNonAlarmVoltageThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowPowerNonAlarmVoltageThresholdOperation
                     cmdFlag:@"010a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerNonAlarmMinSampleIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowPowerNonAlarmMinSampleIntervalOperation
                     cmdFlag:@"010b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerNonAlarmSampleTimesWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowNonAlarmPowerSampleTimesOperation
                     cmdFlag:@"010c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerAlarmVoltageThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowPowerAlarmVoltageThresholdOperation
                     cmdFlag:@"010d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerAlarmMinSampleIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowPowerAlarmMinSampleIntervalOperation
                     cmdFlag:@"010e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerAlarmSampleTimesWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowAlarmPowerSampleTimesOperation
                     cmdFlag:@"010f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙相关参数************************************************

+ (void)ad_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadConnectationNeedPasswordOperation
                     cmdFlag:@"0200"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadPasswordOperation
                     cmdFlag:@"0201"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadBroadcastTimeoutOperation
                     cmdFlag:@"0202"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadBeaconStatusOperation
                     cmdFlag:@"0203"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadAdvIntervalOperation
                     cmdFlag:@"0204"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadTxPowerOperation
                     cmdFlag:@"0205"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadDeviceNameOperation
                     cmdFlag:@"0206"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** LoRaWAN ************************************************

+ (void)ad_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanNetworkStatusOperation
                     cmdFlag:@"0500"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanRegionOperation
                     cmdFlag:@"0501"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanModemOperation
                     cmdFlag:@"0502"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanDEVEUIOperation
                     cmdFlag:@"0503"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanAPPEUIOperation
                     cmdFlag:@"0504"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanAPPKEYOperation
                     cmdFlag:@"0505"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanDEVADDROperation
                     cmdFlag:@"0506"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanAPPSKEYOperation
                     cmdFlag:@"0507"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanNWKSKEYOperation
                     cmdFlag:@"0508"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanADRACKLimitWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanADRACKLimitOperation
                     cmdFlag:@"050a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanADRACKDelayWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanADRACKDelayOperation
                     cmdFlag:@"050b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanCHOperation
                     cmdFlag:@"0520"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanDROperation
                     cmdFlag:@"0521"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanUplinkStrategyOperation
                     cmdFlag:@"0522"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanDutyCycleStatusOperation
                     cmdFlag:@"0523"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanDevTimeSyncIntervalOperation
                     cmdFlag:@"0540"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLorawanNetworkCheckIntervalOperation
                     cmdFlag:@"0541"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readHeartbeatPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadHeartbeatPayloadDataOperation
                     cmdFlag:@"0551"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readLowPowerPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadLowPowerPayloadDataOperation
                     cmdFlag:@"0552"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readEventPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadEventPayloadDataOperation
                     cmdFlag:@"0554"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readAlarmPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ad_taskReadAlarmPayloadDataOperation
                     cmdFlag:@"055e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** Alarm ************************************************

+ (void)ad_readAlarmFunctionSwitchWithType:(mk_ad_alarmType)alarmType
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"0600";
    mk_ad_taskOperationID taskID = mk_ad_taskReadAlarm1FunctionSwitchOperation;
    if (alarmType == mk_ad_alarmType2) {
        cmd = @"0610";
        taskID = mk_ad_taskReadAlarm2FunctionSwitchOperation;
    }else if (alarmType == mk_ad_alarmType3) {
        cmd = @"0620";
        taskID = mk_ad_taskReadAlarm3FunctionSwitchOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readBuzzerTypeAlarmTriggerWithType:(mk_ad_alarmType)alarmType
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"0601";
    mk_ad_taskOperationID taskID = mk_ad_taskReadBuzzerTypeAlarm1TriggerOperation;
    if (alarmType == mk_ad_alarmType2) {
        cmd = @"0611";
        taskID = mk_ad_taskReadBuzzerTypeAlarm2TriggerOperation;
    }else if (alarmType == mk_ad_alarmType3) {
        cmd = @"0621";
        taskID = mk_ad_taskReadBuzzerTypeAlarm3TriggerOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readAlarmExitLongPressTimeWithType:(mk_ad_alarmType)alarmType
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"0602";
    mk_ad_taskOperationID taskID = mk_ad_taskReadAlarm1ExitLongPressTimeOperation;
    if (alarmType == mk_ad_alarmType2) {
        cmd = @"0612";
        taskID = mk_ad_taskReadAlarm2ExitLongPressTimeOperation;
    }else if (alarmType == mk_ad_alarmType3) {
        cmd = @"0622";
        taskID = mk_ad_taskReadAlarm3ExitLongPressTimeOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ad_readAlarmReportIntervalWithType:(mk_ad_alarmType)alarmType
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"0603";
    mk_ad_taskOperationID taskID = mk_ad_taskReadAlarm1ReportIntervalOperation;
    if (alarmType == mk_ad_alarmType2) {
        cmd = @"0613";
        taskID = mk_ad_taskReadAlarm2ReportIntervalOperation;
    }else if (alarmType == mk_ad_alarmType3) {
        cmd = @"0623";
        taskID = mk_ad_taskReadAlarm3ReportIntervalOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_ad_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.ad_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
