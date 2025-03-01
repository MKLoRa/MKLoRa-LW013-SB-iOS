//
//  MKADBatteryInfoCell.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKADBatteryInfoCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"

@implementation MKADBatteryInfoCellModel
@end

@interface MKADBatteryInfoCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *workTimeLabel;

@property (nonatomic, strong)UILabel *advCountLabel;

@property (nonatomic, strong)UILabel *redLightTimeLabel;

@property (nonatomic, strong)UILabel *greenLightTimeLabel;

@property (nonatomic, strong)UILabel *blueLightTimeLabel;

@property (nonatomic, strong)UILabel *buzzerNormalLabel;

@property (nonatomic, strong)UILabel *buzzerAlarmLabel;

@property (nonatomic, strong)UILabel *alarm1TriggerLabel;

@property (nonatomic, strong)UILabel *alarm1PayloadCountLabel;

@property (nonatomic, strong)UILabel *alarm2TriggerLabel;

@property (nonatomic, strong)UILabel *alarm2PayloadCountLabel;

@property (nonatomic, strong)UILabel *alarm3TriggerLabel;

@property (nonatomic, strong)UILabel *alarm3PayloadCountLabel;

@property (nonatomic, strong)UILabel *loraSendCountLabel;

@property (nonatomic, strong)UILabel *loraPowerLabel;

@property (nonatomic, strong)UILabel *batteryPowerLabel;

@end

@implementation MKADBatteryInfoCell

+ (MKADBatteryInfoCell *)initCellWithTableView:(UITableView *)tableView {
    MKADBatteryInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKADBatteryInfoCellIdenty"];
    if (!cell) {
        cell = [[MKADBatteryInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKADBatteryInfoCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.workTimeLabel];
        [self.contentView addSubview:self.advCountLabel];
        [self.contentView addSubview:self.redLightTimeLabel];
        [self.contentView addSubview:self.greenLightTimeLabel];
        [self.contentView addSubview:self.blueLightTimeLabel];
        [self.contentView addSubview:self.buzzerNormalLabel];
        [self.contentView addSubview:self.buzzerAlarmLabel];
        [self.contentView addSubview:self.alarm1TriggerLabel];
        [self.contentView addSubview:self.alarm1PayloadCountLabel];
        [self.contentView addSubview:self.alarm2TriggerLabel];
        [self.contentView addSubview:self.alarm2PayloadCountLabel];
        [self.contentView addSubview:self.alarm3TriggerLabel];
        [self.contentView addSubview:self.alarm3PayloadCountLabel];
        [self.contentView addSubview:self.loraPowerLabel];
        [self.contentView addSubview:self.loraSendCountLabel];
        [self.contentView addSubview:self.batteryPowerLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.workTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.msgLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.advCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.workTimeLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.redLightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.advCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.greenLightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.redLightTimeLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.blueLightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.greenLightTimeLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.buzzerNormalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.greenLightTimeLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.buzzerAlarmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.buzzerNormalLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.alarm1TriggerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.buzzerAlarmLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.alarm1PayloadCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.alarm1TriggerLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.alarm2TriggerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.alarm1PayloadCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.alarm2PayloadCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.alarm2TriggerLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.alarm3TriggerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.alarm2PayloadCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.alarm3PayloadCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.alarm3TriggerLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraSendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.alarm3PayloadCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraSendCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.batteryPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraPowerLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKADBatteryInfoCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKADBatteryInfoCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.workTimeLabel.text = [SafeStr(_dataModel.workTimes) stringByAppendingString:@" s"];
    self.advCountLabel.text = [SafeStr(_dataModel.advCount) stringByAppendingString:@" times"];
    self.redLightTimeLabel.text = [SafeStr(_dataModel.redLightTime) stringByAppendingString:@"s"];
    self.greenLightTimeLabel.text = [SafeStr(_dataModel.greenLightTime) stringByAppendingString:@"s"];
    self.blueLightTimeLabel.text = [SafeStr(_dataModel.blueLightTime) stringByAppendingString:@"s"];
    self.buzzerNormalLabel.text = [SafeStr(_dataModel.buzzerNormalTime) stringByAppendingString:@"s"];
    self.buzzerAlarmLabel.text = [SafeStr(_dataModel.buzzerAlarmTime) stringByAppendingString:@"s"];
    self.alarm1TriggerLabel.text = [SafeStr(_dataModel.alarm1TriggerCount) stringByAppendingString:@" times"];
    self.alarm1PayloadCountLabel.text = [SafeStr(_dataModel.alarm1PayloadCount) stringByAppendingString:@" times"];
    self.alarm2TriggerLabel.text = [SafeStr(_dataModel.alarm2TriggerCount) stringByAppendingString:@" times"];
    self.alarm2PayloadCountLabel.text = [SafeStr(_dataModel.alarm2PayloadCount) stringByAppendingString:@" times"];
    self.alarm3TriggerLabel.text = [SafeStr(_dataModel.alarm3TriggerCount) stringByAppendingString:@" times"];
    self.alarm3PayloadCountLabel.text = [SafeStr(_dataModel.alarm3PayloadCount) stringByAppendingString:@" times"];
    self.loraPowerLabel.text = [SafeStr(_dataModel.loraPowerConsumption) stringByAppendingString:@" mAS"];
    self.loraSendCountLabel.text = [SafeStr(_dataModel.loraSendCount) stringByAppendingString:@" times"];
    self.batteryPowerLabel.text = [NSString stringWithFormat:@"%.3f %@",([_dataModel.batteryPower integerValue] * 0.001),@"mAH"];
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

- (UILabel *)workTimeLabel {
    if (!_workTimeLabel) {
        _workTimeLabel = [self fetchValueLabel];
    }
    return _workTimeLabel;
}

- (UILabel *)advCountLabel {
    if (!_advCountLabel) {
        _advCountLabel = [self fetchValueLabel];
    }
    return _advCountLabel;
}

- (UILabel *)redLightTimeLabel {
    if (!_redLightTimeLabel) {
        _redLightTimeLabel = [self fetchValueLabel];
    }
    return _redLightTimeLabel;
}

- (UILabel *)greenLightTimeLabel {
    if (!_greenLightTimeLabel) {
        _greenLightTimeLabel = [self fetchValueLabel];
    }
    return _greenLightTimeLabel;
}

- (UILabel *)blueLightTimeLabel {
    if (!_blueLightTimeLabel) {
        _blueLightTimeLabel = [self fetchValueLabel];
    }
    return _blueLightTimeLabel;
}

- (UILabel *)buzzerNormalLabel {
    if (!_buzzerNormalLabel) {
        _buzzerNormalLabel = [self fetchValueLabel];
    }
    return _buzzerNormalLabel;
}

- (UILabel *)buzzerAlarmLabel {
    if (!_buzzerAlarmLabel) {
        _buzzerAlarmLabel = [self fetchValueLabel];
    }
    return _buzzerAlarmLabel;
}

- (UILabel *)alarm1TriggerLabel {
    if (!_alarm1TriggerLabel) {
        _alarm1TriggerLabel = [self fetchValueLabel];
    }
    return _alarm1TriggerLabel;
}

- (UILabel *)alarm1PayloadCountLabel {
    if (!_alarm1PayloadCountLabel) {
        _alarm1PayloadCountLabel = [self fetchValueLabel];
    }
    return _alarm1PayloadCountLabel;
}

- (UILabel *)alarm2TriggerLabel {
    if (!_alarm2TriggerLabel) {
        _alarm2TriggerLabel = [self fetchValueLabel];
    }
    return _alarm2TriggerLabel;
}

- (UILabel *)alarm2PayloadCountLabel {
    if (!_alarm2PayloadCountLabel) {
        _alarm2PayloadCountLabel = [self fetchValueLabel];
    }
    return _alarm2PayloadCountLabel;
}

- (UILabel *)alarm3TriggerLabel {
    if (!_alarm3TriggerLabel) {
        _alarm3TriggerLabel = [self fetchValueLabel];
    }
    return _alarm3TriggerLabel;
}

- (UILabel *)alarm3PayloadCountLabel {
    if (!_alarm3PayloadCountLabel) {
        _alarm3PayloadCountLabel = [self fetchValueLabel];
    }
    return _alarm3PayloadCountLabel;
}

- (UILabel *)loraSendCountLabel {
    if (!_loraSendCountLabel) {
        _loraSendCountLabel = [self fetchValueLabel];
    }
    return _loraSendCountLabel;
}

- (UILabel *)loraPowerLabel {
    if (!_loraPowerLabel) {
        _loraPowerLabel = [self fetchValueLabel];
    }
    return _loraPowerLabel;
}

- (UILabel *)batteryPowerLabel {
    if (!_batteryPowerLabel) {
        _batteryPowerLabel = [self fetchValueLabel];
    }
    return _batteryPowerLabel;
}

- (UILabel *)fetchValueLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = DEFAULT_TEXT_COLOR;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = MKFont(13.f);
    return label;
}

@end
