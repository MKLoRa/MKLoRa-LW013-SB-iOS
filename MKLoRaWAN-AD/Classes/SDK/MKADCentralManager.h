//
//  MKADCentralManager.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKBaseBleModule/MKBLEBaseDataProtocol.h>

#import "MKADOperationID.h"
#import "MKADSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

//Notification of device connection status changes.
extern NSString *const mk_ad_peripheralConnectStateChangedNotification;

//Notification of changes in the status of the Bluetooth Center.
extern NSString *const mk_ad_centralManagerStateChangedNotification;

/*
 After connecting the device, if no password is entered within one minute, it returns 0x01. After successful password change, it returns 0x02, the device has no data communication for three consecutive minutes, it returns 0x03, and the shutdown protocol is sent to make the device shut down and return 0x04.Reset the device, return 0x05.
 */
extern NSString *const mk_ad_deviceDisconnectTypeNotification;

@class CBCentralManager,CBPeripheral;
@class MKADOperation;

@interface MKADCentralManager : NSObject<MKBLEBaseCentralManagerProtocol>

@property (nonatomic, weak)id <mk_ad_centralManagerScanDelegate>delegate;

@property (nonatomic, weak)id <mk_ad_centralManagerLogDelegate>logDelegate;

/// Current connection status
@property (nonatomic, assign, readonly)mk_ad_centralConnectStatus connectStatus;

+ (MKADCentralManager *)shared;

/// Destroy the MKADCentralManager singleton and the MKBLEBaseCentralManager singleton. After the dfu upgrade, you need to destroy these two and then reinitialize.
+ (void)sharedDealloc;

/// Destroy the MKADCentralManager singleton and remove the manager list of MKBLEBaseCentralManager.
+ (void)removeFromCentralList;

- (nonnull CBCentralManager *)centralManager;

/// Currently connected devices
- (nullable CBPeripheral *)peripheral;

/// Current Bluetooth center status
- (mk_ad_centralManagerStatus )centralStatus;

/// Bluetooth Center starts scanning
- (void)startScan;

/// Bluetooth center stops scanning
- (void)stopScan;

/// Connect device function.
/// @param peripheral peripheral
/// @param password Device connection password,8 characters long ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Connect device function.
/// @param peripheral peripheral
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnect;

/// Start a task for data communication with the device
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param commandData Data to be sent to the device for this communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addTaskWithTaskID:(mk_ad_taskOperationID)operationID
           characteristic:(CBCharacteristic *)characteristic
              commandData:(NSString *)commandData
             successBlock:(void (^)(id returnData))successBlock
             failureBlock:(void (^)(NSError *error))failureBlock;

/// Start a task to read device characteristic data
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addReadTaskWithTaskID:(mk_ad_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                 successBlock:(void (^)(id returnData))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock;

- (void)addOperation:(MKADOperation *)operation;

/// Whether to open log data monitoring.
/// @param notify notify
- (BOOL)notifyLogData:(BOOL)notify;

@end

NS_ASSUME_NONNULL_END
