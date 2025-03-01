//
//  MKADScanController.h
//  MKLoRaWAN-AD_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKADScanController : MKBaseViewController

/// 0:LW008-MTE     1:LW008-PTE     2:LW001-BGE
@property (nonatomic, assign)NSInteger deviceType;

@end

NS_ASSUME_NONNULL_END
