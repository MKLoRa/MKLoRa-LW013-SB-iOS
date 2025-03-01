//
//  MKADConnectModel.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKADConnectModel : NSObject

+ (MKADConnectModel *)shared;

/// 设备连接的时候是否需要密码
@property (nonatomic, assign, readonly)BOOL hasPassword;

/// 设备类型,   @"00":LR1110    @"10":L76
@property (nonatomic, copy, readonly)NSString *deviceType;

/// 连接设备
/// @param peripheral 设备
/// @param password 密码
/// @param deviceType 00:LR1110    10:L76
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
- (void)connectDevice:(CBPeripheral *)peripheral
             password:(NSString *)password
           deviceType:(NSString *)deviceType
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
