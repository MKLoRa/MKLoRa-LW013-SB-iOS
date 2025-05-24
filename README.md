# LW013-SB iOS Software Development Kit Guide

* This SDK only support devices based on LW013-SB.

## Design instructions

* We divide the communications between SDK and devices into two stages: Scanning stage, Connection stage.For ease of understanding, let’s take a look at the related classes and the relationships between them.

`MKADCentralManager`：global manager, check system’s bluetooth status, listen status changes, the most important is scan and connect to devices;

`MKADInterface`: When the device is successfully connected, the device data can be read through the interface in `MKADInterface `;

`MKADInterface+MKADConfig`: When the device is successfully connected, you can configure the device data through the interface in `MKADInterface + MKADConfig `;


## Scanning Stage

in this stage, `MKADCentralManager` will scan and analyze the advertisement data of LW013-SB devices.


## Connection Stage

The device broadcast information includes whether a password is required when connecting.

1.Enter the password to connect, then call the following method to connect:
`connectPeripheral:password:sucBlock:failedBlock:`
2.You do not need to enter a password to connect, call the following method to connect:
`connectPeripheral:sucBlock:failedBlock:`


# Get Started

### Development environment:

* Xcode9+， due to the DFU and Zip Framework based on Swift4.0, so please use Xcode9 or high version to develop;
* iOS14, we limit the minimum iOS system version to 14.0；

### Import to Project

CocoaPods

SDK is available through CocoaPods.To install it, simply add the following line to your Podfile, and then import <MKLoRaWAN-AD/MKADSDK.h>:

**pod 'MKLoRaWAN-AD/SDK'**


* <font color=#FF0000 face="黑体">You need add the string to “info.plist” file of your project: Privacy - Bluetooth Peripheral Usage Description - “your description”. as the screenshot below.</font>

*  <font color=#FF0000 face="黑体"> You need to add a string to the project’s info.plist file: Privacy-Bluetooth Always Usage Description-“Your usage description”.</font>


## Start Developing

### Get sharedInstance of Manager

First of all, the developer should get the sharedInstance of Manager:

```
MKADCentralManager *manager = [MKADCentralManager shared];
```

#### 1.Start scanning task to find devices around you,please follow the steps below:

* 1.Set the scan delegate and complete the related delegate methods.

```
manager.delegate = self;
```

* 2.you can start the scanning task in this way:

```
[manager startScan];
```

* 3.at the sometime, you can stop the scanning task in this way:

```
[manager stopScan];
```

#### 2.Connect to device

The `MKADCentralManager ` contains the method of connecting the device.



```
/// Connect device function
/// @param peripheral peripheral
/// @param password Device connection password,8 characters long ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;
```

```
/// Connect device function.
/// @param peripheral peripheral
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;
```

#### 3.Get State

Through the manager, you can get the current Bluetooth status of the mobile phone, and the connection status of the device. If you want to monitor the changes of these two states, you can register the following notifications to achieve:

* When the Bluetooth status of the mobile phone changes，<font color=#FF0000 face="黑体">`mk_ad_centralManagerStateChangedNotification`</font> will be posted.You can get status in this way:

```
[[MKADCentralManager shared] centralStatus];
```

* When the device connection status changes， <font color=#FF0000 face="黑体"> `mk_ad_peripheralConnectStateChangedNotification` </font> will be posted.You can get the status in this way:

```
[MKADCentralManager shared].connectStatus;
```

#### 4.Monitoring device disconnect reason.

Register for <font color=#FF0000 face="黑体"> `mk_ad_deviceDisconnectTypeNotification` </font> notifications to monitor data.


```
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectTypeNotification:)
                                                 name:@"mk_ad_deviceDisconnectTypeNotification"
                                               object:nil];

```

```
- (void)disconnectTypeNotification:(NSNotification *)note {
    NSString *type = note.userInfo[@"type"];
    /*
    After connecting the device, if no password is entered within one minute, it returns 0x01. The device has no data communication for three consecutive minutes, it returns 0x02, and the shutdown protocol is sent to make the device shut down and return 0x03.Reset the device, return 0x04.After successful password change, it returns 0x05.
    */
}
```

#### 5.Monitor the log of device operation

When the device is connected, you can monitor the log information of the device operation through the following steps:

*  1.Enable the log data monitoring function.

```
[[MKADCentralManager shared] notifyLogData:YES];
```


*  2.Set the data proxy and implement the related proxy methods:

```

[MKADCentralManager shared].logDelegate = self;
                                               
```

* 3.Data Example Explanation

```
 #pragma mark - mk_ad_centralManagerLogDelegate
- (void)mk_ad_receiveLog:(NSString *)deviceLog {
    //deviceLog is an ASCII string.
}
```

# Change log

* 20250507 first version;
