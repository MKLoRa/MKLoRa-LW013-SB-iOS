//
//  MKADDebuggerCell.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2021/12/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADDebuggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *timeMsg;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *logInfo;

@end

@protocol MKADDebuggerCellDelegate <NSObject>

- (void)ad_debuggerCellSelectedChanged:(NSInteger)index selected:(BOOL)selected;

@end

@interface MKADDebuggerCell : MKBaseCell

@property (nonatomic, strong)MKADDebuggerCellModel *dataModel;

@property (nonatomic, weak)id <MKADDebuggerCellDelegate>delegate;

+ (MKADDebuggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
