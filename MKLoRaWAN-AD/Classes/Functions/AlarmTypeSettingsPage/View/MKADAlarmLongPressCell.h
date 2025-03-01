//
//  MKADAlarmLongPressCell.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2025/3/1.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADAlarmLongPressCellModel : NSObject

@property (nonatomic, copy)NSString *time;

@end

@protocol MKADAlarmLongPressCellDelegate <NSObject>

- (void)ad_alarmLongPressCell_timeChanged:(NSString *)time;

@end

@interface MKADAlarmLongPressCell : MKBaseCell

@property (nonatomic, strong)MKADAlarmLongPressCellModel *dataModel;

@property (nonatomic, weak)id <MKADAlarmLongPressCellDelegate>delegate;

+ (MKADAlarmLongPressCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
