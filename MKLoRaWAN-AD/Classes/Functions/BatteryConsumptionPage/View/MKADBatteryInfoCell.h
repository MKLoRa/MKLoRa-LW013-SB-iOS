//
//  MKADBatteryInfoCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADBatteryInfoCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *workTimes;

@property (nonatomic, copy)NSString *advCount;

@property (nonatomic, copy)NSString *redLightTime;

@property (nonatomic, copy)NSString *greenLightTime;

@property (nonatomic, copy)NSString *blueLightTime;

@property (nonatomic, copy)NSString *buzzerNormalTime;

@property (nonatomic, copy)NSString *buzzerAlarmTime;

@property (nonatomic, copy)NSString *alarm1TriggerCount;

@property (nonatomic, copy)NSString *alarm1PayloadCount;

@property (nonatomic, copy)NSString *alarm2TriggerCount;

@property (nonatomic, copy)NSString *alarm2PayloadCount;

@property (nonatomic, copy)NSString *alarm3TriggerCount;

@property (nonatomic, copy)NSString *alarm3PayloadCount;

@property (nonatomic, copy)NSString *loraSendCount;

@property (nonatomic, copy)NSString *loraPowerConsumption;

@property (nonatomic, copy)NSString *batteryPower;

@end

@interface MKADBatteryInfoCell : MKBaseCell

@property (nonatomic, strong)MKADBatteryInfoCellModel *dataModel;

+ (MKADBatteryInfoCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
