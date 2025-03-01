//
//  MKADBatteryConsumptionModel.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/8.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADBatteryConsumptionModel : NSObject

@property (nonatomic, strong)NSDictionary *currentInfo;

@property (nonatomic, strong)NSDictionary *allInfo;

@property (nonatomic, strong)NSDictionary *lastInfo;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
