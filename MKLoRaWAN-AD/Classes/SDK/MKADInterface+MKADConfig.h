//
//  MKADInterface+MKADConfig.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKADInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKADInterface (MKADConfig)

#pragma mark ****************************************System************************************************

/// Device shutdown.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_powerOffWithSucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Restart the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_factoryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Sync device time.
/// @param timestamp UTC
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configDeviceTime:(unsigned long)timestamp
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the time zone of the device.
/// @param timeZone -24~28  //(The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00.eg:timeZone = -23 ,--> UTC-11:30)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Interval.
/// @param interval 1Min~14400Mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configHeartbeatInterval:(NSInteger)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Indicator Settings.
/// @param protocol protocol.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configIndicatorSettings:(id <mk_ad_indicatorSettingsProtocol>)protocol
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Choice of how to powe on using magnets.
/// @param method method.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configMagnetTurnOnMethod:(mk_ad_magnetTurnOnMethod)method
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

///  Hall Power Off Status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configHallPowerOffStatus:(BOOL)isOn
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Shutdown Payload Status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configShutdownPayloadStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** Battery ************************************************


/// Battery Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_batteryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// When the power of the device is lower than how much, it is judged as a low power state.
/// @param prompt 30%~99%
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLowPowerPrompt:(NSInteger)prompt
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

///  Whether to trigger a heartbeat when the device is low on battery.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLowPowerPayloadStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Low power information packet reporting interval in low power state.
/// @param interval 1×30mins ~ 255×30mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLowPowerPayloadInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Non-alarm Voltage Threshold.
/// @param threshold 44~64,unit:0.05v. 44=2.2v, 64=3.2v.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLowPowerNonAlarmVoltageThreshold:(NSInteger)threshold
                                         sucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Non-alarm Min. Sample Interval.
/// @param interval 1Min~14400Mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLowPowerNonAlarmMinSampleInterval:(NSInteger)interval
                                          sucBlock:(void (^)(void))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Non-alarm Sample Times.
/// @param times 1~100.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLowPowerNonAlarmSampleTimes:(NSInteger)times
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Alarm Voltage Threshold.
/// @param threshold 44~64,unit:0.05v. 44=2.2v, 64=3.2v.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLowPowerAlarmVoltageThreshold:(NSInteger)threshold
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Alarm Min. Sample Interval.
/// @param interval 1Min~14400Mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLowPowerAlarmMinSampleInterval:(NSInteger)interval
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Alarm Sample Times.
/// @param times 1~100.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLowPowerAlarmSampleTimes:(NSInteger)times
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************蓝牙相关参数************************************************

/// Do you need a password when configuring the device connection.
/// @param need need
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configNeedPassword:(BOOL)need
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the connection password of device.
/// @param password 8-character ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configPassword:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast timeout time in Bluetooth configuration mode.
/// @param timeout 1Min~60Mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configBroadcastTimeout:(NSInteger)timeout
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Beacon status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configBeaconStatus:(BOOL)isOn
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Adv interval of the device.
/// @param interval 1~100(Unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configAdvInterval:(NSInteger)interval
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the txPower of device.
/// @param txPower txPower
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configTxPower:(mk_ad_txPower)txPower
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast name of the device.
/// @param deviceName 0~16 ascii characters
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configDeviceName:(NSString *)deviceName
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************设备lorawan信息设置************************************************

/// Configure the region information of LoRaWAN.
/// @param region region
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configRegion:(mk_ad_loraWanRegion)region
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN network access type.
/// @param modem modem
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configModem:(mk_ad_loraWanModem)modem
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVEUI of LoRaWAN.
/// @param devEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configDEVEUI:(NSString *)devEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPEUI of LoRaWAN.
/// @param appEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configAPPEUI:(NSString *)appEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPKEY of LoRaWAN.
/// @param appKey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configAPPKEY:(NSString *)appKey
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVADDR of LoRaWAN.
/// @param devAddr Hexadecimal characters, length must be 8.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configDEVADDR:(NSString *)devAddr
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPSKEY of LoRaWAN.
/// @param appSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configAPPSKEY:(NSString *)appSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the NWKSKEY of LoRaWAN.
/// @param nwkSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configNWKSKEY:(NSString *)nwkSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// The ADR ACK LIMIT Of Lorawan.
/// @param value 1~255
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLorawanADRACKLimit:(NSInteger)value
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The ADR ACK DELAY Of Lorawan.
/// @param value 1~255
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLorawanADRACKDelay:(NSInteger)value
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the CH of LoRaWAN.It is only used for US915,AU915,CN470.
/// @param chlValue Minimum value of CH.0 ~ 95
/// @param chhValue Maximum value of CH. chlValue ~ 95
/// @param sucBlock Success callback
/// @param failedBlock  Failure callback
+ (void)ad_configCHL:(NSInteger)chlValue
                 CHH:(NSInteger)chhValue
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DR of LoRaWAN.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/// @param drValue 0~5
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configDR:(NSInteger)drValue
           sucBlock:(void (^)(void))sucBlock
        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN uplink data sending strategy.
/// @param isOn ADR is on.
/// @param transmissions 1/2
/// @param DRL When the ADR switch is off, the range is 0~6.
/// @param DRH When the ADR switch is off, the range is DRL~6
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configUplinkStrategy:(BOOL)isOn
                  transmissions:(NSInteger)transmissions
                            DRL:(NSInteger)DRL
                            DRH:(NSInteger)DRH
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// It is only used for EU868,CN779, EU433 and RU864. Off: The uplink report interval will not be limit by region freqency. On:The uplink report interval will be limit by region freqency.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configDutyCycleStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Time Sync Interval.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configTimeSyncInterval:(NSInteger)interval
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Network Check Interval Of Lorawan.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLorawanNetworkCheckInterval:(NSInteger)interval
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configHeartbeatPayloadWithMessageType:(mk_ad_loraWanMessageType)type
                             retransmissionTimes:(NSInteger)times
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Low-Power Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configLowPowerPayloadWithMessageType:(mk_ad_loraWanMessageType)type
                            retransmissionTimes:(NSInteger)times
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Event Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configEventPayloadWithMessageType:(mk_ad_loraWanMessageType)type
                         retransmissionTimes:(NSInteger)times
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configAlarmPayloadWithMessageType:(mk_ad_loraWanMessageType)type
                         retransmissionTimes:(NSInteger)times
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** Alarm ************************************************
/// Alarm Function Switch.
/// @param isOn Alarm Function Switch is on.
/// @param exit exit alarm by button is on.
/// @param alarmType mk_ad_alarmType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configAlarmFunctionSwitch:(BOOL)isOn
                        exitByButton:(BOOL)exit
                           alarmType:(mk_ad_alarmType)alarmType
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Buzzer Type When Alarm was triggered.
/// @param buzzerType mk_ad_alarmBuzzerType.
/// @param alarmType mk_ad_alarmType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configBuzzerTypeAlarmTrigger:(mk_ad_alarmBuzzerType)buzzerType
                              alarmType:(mk_ad_alarmType)alarmType
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Exit alarm type needs the time of long press.
/// @param time 10s~15s.
/// @param alarmType mk_ad_alarmType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configAlarmExitLongPressTime:(NSInteger)time
                              alarmType:(mk_ad_alarmType)alarmType
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm Data Report Interval.
/// @param interval 1s~1440s.
/// @param alarmType mk_ad_alarmType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ad_configAlarmReportInterval:(NSInteger)interval
                           alarmType:(mk_ad_alarmType)alarmType
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
