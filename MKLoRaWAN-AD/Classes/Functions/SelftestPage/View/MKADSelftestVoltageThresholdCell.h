//
//  MKADSelftestVoltageThresholdCell.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2025/4/27.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADSelftestVoltageThresholdCellModel : NSObject

/// 当前cell所在的index
@property (nonatomic, assign)NSInteger index;

/// 左侧显示的msg
@property (nonatomic, copy)NSString *msg;

/// 0~20
@property (nonatomic, assign)NSInteger threshold;

@end

@protocol MKADSelftestVoltageThresholdCellDelegate <NSObject>

- (void)ad_selftestVoltageThresholdCell_thresholdChanged:(NSInteger)index threshold:(NSInteger)threshold;

@end

@interface MKADSelftestVoltageThresholdCell : MKBaseCell

@property (nonatomic, strong)MKADSelftestVoltageThresholdCellModel *dataModel;

@property (nonatomic, weak)id <MKADSelftestVoltageThresholdCellDelegate>delegate;

+ (MKADSelftestVoltageThresholdCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
