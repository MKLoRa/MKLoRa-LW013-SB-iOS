//
//  MKADOnOffSettingsModel.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADOnOffSettingsModel : NSObject

/// 0:Continuous approach  1:Multiple approaches
@property (nonatomic, assign)NSInteger onOffMethod;

@property (nonatomic, assign)BOOL shutDownPayload;

@property (nonatomic, assign)BOOL offByButton;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
