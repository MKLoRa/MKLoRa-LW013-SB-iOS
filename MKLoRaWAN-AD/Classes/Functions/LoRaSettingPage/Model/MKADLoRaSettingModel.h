//
//  MKADLoRaSettingModel.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADLoRaSettingModel : NSObject

//1:ABP,2:OTAA
@property (nonatomic, assign)NSInteger modem;

//OTAA模式/ABP模式
@property (nonatomic, copy)NSString *devEUI;

//OTAA模式/ABP模式
@property (nonatomic, copy)NSString *appEUI;

//OTAA模式
@property (nonatomic, copy)NSString *appKey;

//OTAA模式/ABP模式
@property (nonatomic, copy)NSString *devAddr;

//OTAA模式/ABP模式
@property (nonatomic, copy)NSString *nwkSKey;

//OTAA模式/ABP模式
@property (nonatomic, copy)NSString *appSKey;

/**
 0:AS923
 1:AU915
 2:EU868
 3:KR920
 4:IN865
 5:US915
 6:RU864
 7:AS923-1
 8:AS923-2
 9:AS923-3
 10:AS923-4
 */
@property (nonatomic, assign)NSInteger region;

/// 底部是否需要高级选项
@property (nonatomic, assign)BOOL needAdvanceSetting;

/// 底部高级选项是否打开(needAdvanceSetting == YES情况下)
@property (nonatomic, assign)BOOL advancedStatus;

/// 当频段选择为US915和AU915时，CH设置项显示。US915默认显示值为8-15；AU915默认显示值为8-15.
@property (nonatomic, assign)NSInteger CHL;

/// 当频段选择为US915,和AU915，CH设置项显示。US915默认显示值为8-15；AU915默认显示值为8-15.
@property (nonatomic, assign)NSInteger CHH;

//EU868,RU864
@property (nonatomic, assign)BOOL dutyIsOn;

/// It is only used for EU868,KR920, IN865, RU864
/// 0~15
@property (nonatomic, assign)NSInteger join;

@property (nonatomic, assign)BOOL adrIsOn;

@property (nonatomic, assign)NSInteger DRL;

@property (nonatomic, assign)NSInteger DRH;

/// 1~255
@property (nonatomic, copy)NSString *ackLimit;

/// 1~255
@property (nonatomic, copy)NSString *ackDelay;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

/// 用户主动选择了region，底部高级设置需要按照需求设置为默认值
- (void)configAdvanceSettingDefaultParams;

- (NSArray <NSString *>*)CHLValueList;
- (NSArray <NSString *>*)CHHValueList;
- (NSArray <NSString *>*)DRValueList;
- (NSArray <NSString *>*)DRLValueList;
- (NSArray <NSString *>*)DRHValueList;

@end

NS_ASSUME_NONNULL_END
