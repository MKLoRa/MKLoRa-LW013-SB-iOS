//
//  MKADFilterBeaconCell.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKADFilterBeaconCellDelegate <NSObject>

- (void)mk_ad_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_ad_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKADFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKADFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKADFilterBeaconCellDelegate>delegate;

+ (MKADFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
