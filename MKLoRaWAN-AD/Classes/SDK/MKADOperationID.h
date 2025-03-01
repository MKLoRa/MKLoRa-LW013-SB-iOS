
typedef NS_ENUM(NSInteger, mk_ad_taskOperationID) {
    mk_ad_defaultTaskOperationID,
    
#pragma mark - Read
    mk_ad_taskReadDeviceModelOperation,        //读取产品型号
    mk_ad_taskReadFirmwareOperation,           //读取固件版本
    mk_ad_taskReadHardwareOperation,           //读取硬件类型
    mk_ad_taskReadSoftwareOperation,           //读取软件版本
    mk_ad_taskReadManufacturerOperation,       //读取厂商信息
    mk_ad_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - 系统参数读取
    mk_ad_taskReadMacAddressOperation,              //读取mac地址
    mk_ad_taskReadLowPowerStatusOperation,          //读取低电状态
    mk_ad_taskReadTimeZoneOperation,            //读取时区
    mk_ad_taskReadHeartbeatIntervalOperation,   //读取设备心跳间隔
    mk_ad_taskReadIndicatorSettingsOperation,   //读取指示灯开关状态
    mk_ad_taskReadMagnetTurnOnMethodOperation,  //读取磁铁开机方式选择
    mk_ad_taskReadHallPowerOffStatusOperation,      //读取霍尔关机功能
    mk_ad_taskReadShutdownPayloadStatusOperation,   //读取关机信息上报状态
    mk_ad_taskReadBatteryVoltageOperation,          //读取电池电量
    mk_ad_taskReadPCBAStatusOperation,              //读取产测状态
    mk_ad_taskReadSelftestStatusOperation,          //读取自检故障原因
    
    
#pragma mark - 电池管理参数
    mk_ad_taskReadBatteryInformationOperation,      //读取电池电量消耗
    mk_ad_taskReadLastCycleBatteryInformationOperation, //读取上一周期电池电量消耗
    mk_ad_taskReadAllCycleBatteryInformationOperation,  //读取所有周期电池电量消耗
    mk_ad_taskReadLowPowerPromptOperation,              //读取电池消耗低电百分比
    mk_ad_taskReadLowPowerPayloadStatusOperation,   //读取低电触发心跳开关状态
    mk_ad_taskReadLowPowerPayloadIntervalOperation,     //读取低电状态下低电信息包上报间隔
    
#pragma mark - 蓝牙参数读取
    mk_ad_taskReadConnectationNeedPasswordOperation,    //读取连接是否需要密码
    mk_ad_taskReadPasswordOperation,                    //读取连接密码
    mk_ad_taskReadBroadcastTimeoutOperation,            //读取蓝牙广播超时时间
    mk_ad_taskReadBeaconStatusOperation,                //读取Beacon模式开关
    mk_ad_taskReadAdvIntervalOperation,                 //读取广播间隔
    mk_ad_taskReadTxPowerOperation,                     //读取蓝牙TX Power
    mk_ad_taskReadDeviceNameOperation,                  //读取广播名称
    
    
#pragma mark - 设备控制参数配置
    mk_ad_taskPowerOffOperation,                        //关机
    mk_ad_taskRestartDeviceOperation,                   //配置设备重新入网
    mk_ad_taskFactoryResetOperation,                    //设备恢复出厂设置
    mk_ad_taskConfigDeviceTimeOperation,                //配置时间戳
    mk_ad_taskConfigTimeZoneOperation,                  //配置时区
    mk_ad_taskConfigHeartbeatIntervalOperation,         //配置设备心跳间隔
    mk_ad_taskConfigIndicatorSettingsOperation,         //配置指示灯开关状态
    mk_ad_taskConfigMagnetTurnOnMethodOperation,        //配置磁铁开机方式选择
    mk_ad_taskConfigHallPowerOffStatusOperation,        //配置霍尔关机功能
    mk_ad_taskConfigShutdownPayloadStatusOperation,     //配置关机信息上报状态
    
#pragma mark - 电池管理
    mk_ad_taskBatteryResetOperation,                    //清除电池电量数据
    mk_ad_taskConfigLowPowerPromptOperation,            //配置低电百分比
    mk_ad_taskConfigLowPowerPayloadStatusOperation,     //配置低电触发心跳开关状态
    mk_ad_taskConfigLowPowerPayloadIntervalOperation,   //配置低电状态下低电信息包上报间隔
    
    
#pragma mark - 蓝牙参数配置
    mk_ad_taskConfigNeedPasswordOperation,              //配置是否需要连接密码
    mk_ad_taskConfigPasswordOperation,                  //配置连接密码
    mk_ad_taskConfigBroadcastTimeoutOperation,          //配置蓝牙广播超时时间
    mk_ad_taskConfigBeaconStatusOperation,              //配置Beacon模式开关
    mk_ad_taskConfigAdvIntervalOperation,               //配置广播间隔
    mk_ad_taskConfigTxPowerOperation,                   //配置蓝牙TX Power
    mk_ad_taskConfigDeviceNameOperation,                //配置蓝牙广播名称
    
#pragma mark - 密码特征
    mk_ad_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 设备LoRa参数读取
    mk_ad_taskReadLorawanNetworkStatusOperation,    //读取LoRaWAN网络状态
    mk_ad_taskReadLorawanRegionOperation,           //读取LoRaWAN频段
    mk_ad_taskReadLorawanModemOperation,            //读取LoRaWAN入网类型
    mk_ad_taskReadLorawanDEVEUIOperation,           //读取LoRaWAN DEVEUI
    mk_ad_taskReadLorawanAPPEUIOperation,           //读取LoRaWAN APPEUI
    mk_ad_taskReadLorawanAPPKEYOperation,           //读取LoRaWAN APPKEY
    mk_ad_taskReadLorawanDEVADDROperation,          //读取LoRaWAN DEVADDR
    mk_ad_taskReadLorawanAPPSKEYOperation,          //读取LoRaWAN APPSKEY
    mk_ad_taskReadLorawanNWKSKEYOperation,          //读取LoRaWAN NWKSKEY
    mk_ad_taskReadLorawanADRACKLimitOperation,              //读取ADR_ACK_LIMIT
    mk_ad_taskReadLorawanADRACKDelayOperation,              //读取ADR_ACK_DELAY
    mk_ad_taskReadLorawanCHOperation,               //读取LoRaWAN CH
    mk_ad_taskReadLorawanDROperation,               //读取LoRaWAN DR
    mk_ad_taskReadLorawanUplinkStrategyOperation,   //读取LoRaWAN数据发送策略
    mk_ad_taskReadLorawanDutyCycleStatusOperation,  //读取dutycyle
    mk_ad_taskReadLorawanDevTimeSyncIntervalOperation,  //读取同步时间同步间隔
    mk_ad_taskReadLorawanNetworkCheckIntervalOperation, //读取网络确认间隔
    mk_ad_taskReadHeartbeatPayloadDataOperation,            //读取心跳包上行配置
    mk_ad_taskReadLowPowerPayloadDataOperation,             //读取低电包上行配置
    mk_ad_taskReadEventPayloadDataOperation,                //读取事件信息包上行配置
    mk_ad_taskReadAlarmPayloadDataOperation,                //读取报警信息包上行配置
    
#pragma mark - 读取报警参数
    mk_ad_taskReadAlarm1FunctionSwitchOperation,            //读取事件类型1开关状态
    mk_ad_taskReadBuzzerTypeAlarm1TriggerOperation,         //读取事件类型1蜂鸣器类型
    mk_ad_taskReadAlarm1ExitLongPressTimeOperation,         //读取时间类型1解除报警按键时长
    mk_ad_taskReadAlarm1ReportIntervalOperation,            //读取时间类型1上报间隔
    mk_ad_taskReadAlarm2FunctionSwitchOperation,            //读取事件类型2开关状态
    mk_ad_taskReadBuzzerTypeAlarm2TriggerOperation,         //读取事件类型2蜂鸣器类型
    mk_ad_taskReadAlarm2ExitLongPressTimeOperation,         //读取时间类型2解除报警按键时长
    mk_ad_taskReadAlarm2ReportIntervalOperation,            //读取时间类型2上报间隔
    mk_ad_taskReadAlarm3FunctionSwitchOperation,            //读取事件类型3开关状态
    mk_ad_taskReadBuzzerTypeAlarm3TriggerOperation,         //读取事件类型3蜂鸣器类型
    mk_ad_taskReadAlarm3ExitLongPressTimeOperation,         //读取时间类型3解除报警按键时长
    mk_ad_taskReadAlarm3ReportIntervalOperation,            //读取时间类型3上报间隔
    
#pragma mark - 设备LoRa参数配置
    mk_ad_taskConfigRegionOperation,                    //配置LoRaWAN的region
    mk_ad_taskConfigModemOperation,                     //配置LoRaWAN的入网类型
    mk_ad_taskConfigDEVEUIOperation,                    //配置LoRaWAN的devEUI
    mk_ad_taskConfigAPPEUIOperation,                    //配置LoRaWAN的appEUI
    mk_ad_taskConfigAPPKEYOperation,                    //配置LoRaWAN的appKey
    mk_ad_taskConfigDEVADDROperation,                   //配置LoRaWAN的DevAddr
    mk_ad_taskConfigAPPSKEYOperation,                   //配置LoRaWAN的APPSKEY
    mk_ad_taskConfigNWKSKEYOperation,                   //配置LoRaWAN的NwkSKey
    mk_ad_taskConfigLorawanADRACKLimitOperation,        //配置ADR_ACK_LIMIT
    mk_ad_taskConfigLorawanADRACKDelayOperation,        //配置ADR_ACK_DELAY
    mk_ad_taskConfigCHValueOperation,                   //配置LoRaWAN的CH值
    mk_ad_taskConfigDRValueOperation,                   //配置LoRaWAN的DR值
    mk_ad_taskConfigUplinkStrategyOperation,            //配置LoRaWAN数据发送策略
    mk_ad_taskConfigDutyCycleStatusOperation,           //配置LoRaWAN的duty cycle
    mk_ad_taskConfigTimeSyncIntervalOperation,          //配置LoRaWAN的同步指令间隔
    mk_ad_taskConfigNetworkCheckIntervalOperation,      //配置LoRaWAN的LinkCheckReq间隔
    mk_ad_taskConfigHeartbeatPayloadOperation,          //配置心跳包上行配置
    mk_ad_taskConfigLowPowerPayloadOperation,           //配置低电包上行配置
    mk_ad_taskConfigEventPayloadWithMessageTypeOperation,   //配置事件信息包上行配置
    mk_ad_taskConfigAlarmPayloadWithMessageTypeOperation,   //配置报警信息包上行配置
    
#pragma mark - 配置报警参数
    mk_ad_taskConfigAlarm1FunctionSwitchOperation,            //配置事件类型1开关状态
    mk_ad_taskConfigBuzzerTypeAlarm1TriggerOperation,         //配置事件类型1蜂鸣器类型
    mk_ad_taskConfigAlarm1ExitLongPressTimeOperation,         //配置事件类型1解除报警按键时长
    mk_ad_taskConfigAlarm1ReportIntervalOperation,            //配置事件类型1上报间隔
    mk_ad_taskConfigAlarm2FunctionSwitchOperation,            //配置事件类型2开关状态
    mk_ad_taskConfigBuzzerTypeAlarm2TriggerOperation,         //配置事件类型2蜂鸣器类型
    mk_ad_taskConfigAlarm2ExitLongPressTimeOperation,         //配置事件类型2解除报警按键时长
    mk_ad_taskConfigAlarm2ReportIntervalOperation,            //配置事件类型2上报间隔
    mk_ad_taskConfigAlarm3FunctionSwitchOperation,            //配置事件类型3开关状态
    mk_ad_taskConfigBuzzerTypeAlarm3TriggerOperation,         //配置事件类型3蜂鸣器类型
    mk_ad_taskConfigAlarm3ExitLongPressTimeOperation,         //配置事件类型3解除报警按键时长
    mk_ad_taskConfigAlarm3ReportIntervalOperation,            //配置事件类型3上报间隔
};
