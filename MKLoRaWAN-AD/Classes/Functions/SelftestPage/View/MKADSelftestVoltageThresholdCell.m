//
//  MKADSelftestVoltageThresholdCell.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2025/4/27.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKADSelftestVoltageThresholdCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKPickerView.h"

@implementation MKADSelftestVoltageThresholdCellModel
@end

@interface MKADSelftestVoltageThresholdCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *selectedButton;

@property (nonatomic, strong)UILabel *unitLabel;

@property (nonatomic, strong)NSArray *thresholdList;

@end

@implementation MKADSelftestVoltageThresholdCell

+ (MKADSelftestVoltageThresholdCell *)initCellWithTableView:(UITableView *)tableView {
    MKADSelftestVoltageThresholdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKADSelftestVoltageThresholdCellIdenty"];
    if (!cell) {
        cell = [[MKADSelftestVoltageThresholdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKADSelftestVoltageThresholdCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.selectedButton];
        [self.contentView addSubview:self.unitLabel];
    }
    return self;
}

#pragma mark - super method
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.selectedButton.mas_left).mas_offset(-10.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.unitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.selectedButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.unitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(50.f);
        make.centerY.mas_equalTo(self.msgLabel.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - event method
- (void)selectedButtonPressed {
    //隐藏其他cell里面的输入框键盘
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MKTextFieldNeedHiddenKeyboard" object:nil];
    NSInteger row = 0;
    for (NSInteger i = 0; i < self.thresholdList.count; i ++) {
        if ([self.selectedButton.titleLabel.text isEqualToString:self.thresholdList[i]]) {
            row = i;
            break;
        }
    }
    MKPickerView *pickView = [[MKPickerView alloc] init];
    [pickView showPickViewWithDataList:self.thresholdList selectedRow:row block:^(NSInteger currentRow) {
        [self.selectedButton setTitle:self.thresholdList[currentRow] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(ad_selftestVoltageThresholdCell_thresholdChanged:threshold:)]) {
            [self.delegate ad_selftestVoltageThresholdCell_thresholdChanged:self.dataModel.index threshold:currentRow];
        }
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKADSelftestVoltageThresholdCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKADSelftestVoltageThresholdCellModel.class] || _dataModel.threshold > 20) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    [self.selectedButton setTitle:self.thresholdList[_dataModel.threshold] forState:UIControlStateNormal];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.textColor = DEFAULT_TEXT_COLOR;
        _unitLabel.font = MKFont(13.f);
        _unitLabel.textAlignment = NSTextAlignmentLeft;
        _unitLabel.text = @"V";
    }
    return _unitLabel;
}

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton setTitleColor:COLOR_WHITE_MACROS forState:UIControlStateNormal];
        [_selectedButton setBackgroundColor:NAVBAR_COLOR_MACROS];
        [_selectedButton.layer setMasksToBounds:YES];
        [_selectedButton.layer setCornerRadius:6.f];
        [_selectedButton addTarget:self
                            action:@selector(selectedButtonPressed)
                  forControlEvents:UIControlEventTouchUpInside];
        _selectedButton.titleLabel.font = MKFont(13.f);
    }
    return _selectedButton;
}

- (NSArray *)thresholdList {
    if (!_thresholdList) {
        _thresholdList = @[@"2.2",@"2.25",@"2.3",@"2.35",@"2.4",
                           @"2.45",@"2.5",@"2.55",@"2.6",@"2.65",
                           @"2.7",@"2.75",@"2.8",@"2.85",@"2.9",
                           @"2.95",@"3.0",@"3.05",@"3.1",@"3.15",
                           @"3.2"];
    }
    return _thresholdList;
}

@end
