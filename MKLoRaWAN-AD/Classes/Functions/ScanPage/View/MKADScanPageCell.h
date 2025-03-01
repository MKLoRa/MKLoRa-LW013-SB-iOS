//
//  MKADScanPageCell.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKADScanPageCellDelegate <NSObject>

/// 连接按钮点击事件
/// @param index 当前cell的row
- (void)ad_scanCellConnectButtonPressed:(NSInteger)index;

@end

@class MKADScanPageModel;
@interface MKADScanPageCell : MKBaseCell

@property (nonatomic, strong)MKADScanPageModel *dataModel;

@property (nonatomic, weak)id <MKADScanPageCellDelegate>delegate;

+ (MKADScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
