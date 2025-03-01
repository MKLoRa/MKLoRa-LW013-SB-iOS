#pragma mark ****************************************Enumerate************************************************

#pragma mark - MKADCentralManager

typedef NS_ENUM(NSInteger, mk_ad_centralConnectStatus) {
    mk_ad_centralConnectStatusUnknow,                                           //未知状态
    mk_ad_centralConnectStatusConnecting,                                       //正在连接
    mk_ad_centralConnectStatusConnected,                                        //连接成功
    mk_ad_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_ad_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_ad_centralManagerStatus) {
    mk_ad_centralManagerStatusUnable,                           //不可用
    mk_ad_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_ad_scanDeviceType) {
    mk_ad_scanDeviceType_mte,                           //008-MTE
    mk_ad_scanDeviceType_pte,                           //008-PTE
    mk_ad_scanDeviceType_bge                            //001-BGE
};


typedef NS_ENUM(NSInteger, mk_ad_magnetTurnOnMethod) {
    mk_ad_magnetTurnOnMethod_multipleApproaches,                           //Multiple approaches
    mk_ad_magnetTurnOnMethod_continuousApproach,                           //Continuous approach
};

typedef NS_ENUM(NSInteger, mk_ad_loraWanRegion) {
    mk_ad_loraWanRegionAS923,
    mk_ad_loraWanRegionAU915,
    mk_ad_loraWanRegionEU868,
    mk_ad_loraWanRegionKR920,
    mk_ad_loraWanRegionIN865,
    mk_ad_loraWanRegionUS915,
    mk_ad_loraWanRegionRU864,
    mk_ad_loraWanRegionAS923_1,
    mk_ad_loraWanRegionAS923_2,
    mk_ad_loraWanRegionAS923_3,
    mk_ad_loraWanRegionAS923_4,
};

typedef NS_ENUM(NSInteger, mk_ad_loraWanModem) {
    mk_ad_loraWanModemABP,
    mk_ad_loraWanModemOTAA,
};

typedef NS_ENUM(NSInteger, mk_ad_loraWanMessageType) {
    mk_ad_loraWanUnconfirmMessage,          //Non-acknowledgement frame.
    mk_ad_loraWanConfirmMessage,            //Confirm the frame.
};

typedef NS_ENUM(NSInteger, mk_ad_txPower) {
    mk_ad_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_ad_txPowerNeg20dBm,   //-20dBm
    mk_ad_txPowerNeg16dBm,   //-16dBm
    mk_ad_txPowerNeg12dBm,   //-12dBm
    mk_ad_txPowerNeg8dBm,    //-8dBm
    mk_ad_txPowerNeg4dBm,    //-4dBm
    mk_ad_txPower0dBm,       //0dBm
    mk_ad_txPower3dBm,       //3dBm
    mk_ad_txPower4dBm,       //4dBm
};

typedef NS_ENUM(NSInteger, mk_ad_detectionStatus) {
    mk_ad_detectionStatus_noMotionDetected,
    mk_ad_detectionStatus_motionDetected,
    mk_ad_detectionStatus_all
};

typedef NS_ENUM(NSInteger, mk_ad_sensorSensitivity) {
    mk_ad_sensorSensitivity_low,
    mk_ad_sensorSensitivity_medium,
    mk_ad_sensorSensitivity_high,
    mk_ad_sensorSensitivity_all
};

typedef NS_ENUM(NSInteger, mk_ad_alarmType) {
    mk_ad_alarmType1,
    mk_ad_alarmType2,
    mk_ad_alarmType3
};

typedef NS_ENUM(NSInteger, mk_ad_alarmBuzzerType) {
    mk_ad_alarmBuzzerType_no,
    mk_ad_alarmBuzzerType_normal,
    mk_ad_alarmBuzzerType_alarm
};

@protocol mk_ad_indicatorSettingsProtocol <NSObject>

@property (nonatomic, assign)BOOL LowPower;
@property (nonatomic, assign)BOOL NetworkCheck;
@property (nonatomic, assign)BOOL Broadcast;
@property (nonatomic, assign)BOOL Alarm1Trigger;
@property (nonatomic, assign)BOOL Alarm1Exit;
@property (nonatomic, assign)BOOL Alarm2Trigger;
@property (nonatomic, assign)BOOL Alarm2Exit;
@property (nonatomic, assign)BOOL Alarm3Trigger;
@property (nonatomic, assign)BOOL Alarm3Exit;

@end


#pragma mark ****************************************Delegate************************************************

@protocol mk_ad_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
/*
 @{
 @"rssi":@(-55),
 @"peripheral":peripheral,
 @"deviceName":@"LW008-MT",
 
 @"deviceType":@"00",           //@"00":LR1110  @"10":L76
 @"txPower":@(-55),             //dBm
 @"deviceState":@"0",           //0 (Standby Mode), 1 (Timing Mode), 2 (Periodic Mode), 3 (Motion Mode)
 @"lowPower":@(lowPower),       //Whether the device is in a low battery state.
 @"needPassword":@(YES),
 @"idle":@(NO),               //Whether the device is idle.
 @"move":@(YES),               //Whether there is any movement from the last lora payload to the current broadcast moment (for example, 0 means no movement, 1 means movement).
 @"voltage":@"3.333",           //V
 @"macAddress":@"AA:BB:CC:DD:EE:FF",
 @"connectable":advDic[CBAdvertisementDataIsConnectable],
 }
 */
- (void)mk_ad_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_ad_startScan;

/// Stops scanning equipment.
- (void)mk_ad_stopScan;

@end


@protocol mk_ad_centralManagerLogDelegate <NSObject>

- (void)mk_ad_receiveLog:(NSString *)deviceLog;

@end
