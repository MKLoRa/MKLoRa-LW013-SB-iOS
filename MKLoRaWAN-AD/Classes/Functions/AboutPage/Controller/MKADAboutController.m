//
//  MKADAboutController.m
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKADAboutController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

@interface MKADAboutController ()

@property (nonatomic, strong)UIImageView *aboutIcon;

@property (nonatomic, strong)UILabel *appNameLabel;

@property (nonatomic, strong)UILabel *versionLabel;

@property (nonatomic, strong)UILabel *firmwareLabel;

@property (nonatomic, strong)UILabel *companyNameLabel;

@property (nonatomic, strong)UILabel *companyNetLabel;

@property (nonatomic, strong)UIImageView *bottomIcon;

@end

@implementation MKADAboutController

- (void)dealloc {
    NSLog(@"MKADAboutController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
}

#pragma mark - event method
- (void)openWebBrowser{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.mokosmart.com"]
                                       options:@{}
                             completionHandler:nil];
}

#pragma mark - ui
- (void)loadSubViews {
    self.defaultTitle = @"ABOUT";
    [self.rightButton setHidden:YES];
    [self.view addSubview:self.aboutIcon];
    [self.view addSubview:self.appNameLabel];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.firmwareLabel];
    [self.view addSubview:self.bottomIcon];
    [self.view addSubview:self.companyNameLabel];
    [self.view addSubview:self.companyNetLabel];
    [self.aboutIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(110.f);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(40.f);
        make.height.mas_equalTo(110.f);
    }];
    [self.appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.aboutIcon.mas_bottom).mas_offset(17.f);
        make.height.mas_equalTo(MKFont(20.f).lineHeight);
    }];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.appNameLabel.mas_bottom).mas_offset(17.f);
        make.height.mas_equalTo(MKFont(16.f).lineHeight);
    }];
    [self.firmwareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.versionLabel.mas_bottom).mas_offset(17.f);
        make.height.mas_equalTo(MKFont(16.f).lineHeight);
    }];
    [self.companyNetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-60);
        make.height.mas_equalTo(MKFont(16).lineHeight);
    }];
    [self.companyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.companyNetLabel.mas_top).mas_offset(-17);
        make.height.mas_equalTo(MKFont(17).lineHeight);
    }];
    [self.bottomIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.height.mas_equalTo(213.f);
    }];
}

#pragma mark - setter & getter

- (UILabel *)appNameLabel{
    if (!_appNameLabel) {
        _appNameLabel = [[UILabel alloc] init];
        _appNameLabel.textColor = DEFAULT_TEXT_COLOR;
        _appNameLabel.textAlignment = NSTextAlignmentCenter;
        _appNameLabel.font = MKFont(20.f);
        _appNameLabel.text = @"LW013-SB";
    }
    return _appNameLabel;
}

- (UIImageView *)aboutIcon{
    if (!_aboutIcon) {
        _aboutIcon = [[UIImageView alloc] init];
        _aboutIcon.image = LOADICON(@"MKLoRaWAN-AD", @"MKADAboutController", @"ad_aboutIcon.png");
    }
    return _aboutIcon;
}

- (UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.textColor = RGBCOLOR(189, 189, 189);
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.font = MKFont(16.f);
        _versionLabel.text = [@"APP Version:" stringByAppendingString:kAppVersion];
    }
    return _versionLabel;
}

- (UILabel *)firmwareLabel{
    if (!_firmwareLabel) {
        _firmwareLabel = [[UILabel alloc] init];
        _firmwareLabel.textColor = RGBCOLOR(189, 189, 189);
        _firmwareLabel.textAlignment = NSTextAlignmentCenter;
        _firmwareLabel.font = MKFont(16.f);
        _firmwareLabel.text = @"FW Version:V1.0";
    }
    return _firmwareLabel;
}

- (UILabel *)companyNameLabel{
    if (!_companyNameLabel) {
        _companyNameLabel = [[UILabel alloc] init];
        _companyNameLabel.textColor = DEFAULT_TEXT_COLOR;
        _companyNameLabel.textAlignment = NSTextAlignmentCenter;
        _companyNameLabel.font = MKFont(16.f);
        _companyNameLabel.text = @"MOKO TECHNOLOGY LTD.";
    }
    return _companyNameLabel;
}

- (UILabel *)companyNetLabel{
    if (!_companyNetLabel) {
        _companyNetLabel = [[UILabel alloc] init];
        _companyNetLabel.textAlignment = NSTextAlignmentCenter;
        _companyNetLabel.textColor = NAVBAR_COLOR_MACROS;
        _companyNetLabel.font = MKFont(16.f);
        _companyNetLabel.text = @"www.mokosmart.com";
        [_companyNetLabel addTapAction:self selector:@selector(openWebBrowser)];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = RGBCOLOR(3, 191, 234);
        [_companyNetLabel addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_companyNetLabel.mas_centerX);
            make.width.mas_equalTo(155);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5f);
        }];
    }
    return _companyNetLabel;
}

- (UIImageView *)bottomIcon {
    if (!_bottomIcon) {
        _bottomIcon = [[UIImageView alloc] init];
        _bottomIcon.userInteractionEnabled = YES;
        _bottomIcon.image = LOADICON(@"MKLoRaWAN-AD", @"MKADAboutController", @"ad_aboutBottomIcon.png");
    }
    return _bottomIcon;
}

@end
