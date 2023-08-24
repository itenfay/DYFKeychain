English Vision | [中文版](README-zh.md)

## DYFKeychain

This is used to store text and data in the Keychain([Swift Version](https://github.com/chenxing640/DYFSwiftKeychain)). As you probably noticed Apple's keychain API is a bit verbose. This library was designed to provide shorter syntax for accomplishing a simple task: reading/writing text values for specified keys:

```objc
DYFKeychain *keychain = [DYFKeychain createKeychain];
[keychain add:@"User Account Passcode" forKey:@"kUserAccPasscode"];
NSString *p = [keychain get:@"kUserAccPasscode"];
```

The Keychain library includes the following features:

- Get, set and delete string, boolean and Data Keychain items.
- Specify item access security level.
- Synchronize items through iCloud.
- Share Keychain items with other apps.

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;
[![CocoaPods Version](http://img.shields.io/cocoapods/v/DYFKeychain.svg?style=flat)](http://cocoapods.org/pods/DYFKeychain)&nbsp;
![CocoaPods Platform](http://img.shields.io/cocoapods/p/DYFKeychain.svg?style=flat)&nbsp;


## Group (ID:614799921)

<div align=left>
&emsp; <img src="https://github.com/chenxing640/DYFKeychain/raw/master/images/g614799921.jpg" width="30%" />
</div>


## Installation

Using [CocoaPods](https://cocoapods.org):

``` 
target 'Your target name'

pod 'DYFKeychain'
or
pod 'DYFKeychain', '~> 1.1.0'
```

Or manually add the files from the [Keychain](https://github.com/chenxing640/DYFKeychain/tree/master/Keychain) directory.


## What's Keychain?

Keychain is a secure storage. You can store all kind of sensitive data in it: user passwords, credit card numbers, secret tokens etc. Once stored in Keychain this information is only available to your app, other apps can't see it. Besides that, operating system makes sure this information is kept and processed securely. For example, text stored in Keychain can not be extracted from iPhone backup or from its file system. Apple recommends storing only small amount of data in the Keychain. If you need to secure something big you can encrypt it manually, save to a file and store the key in the Keychain.


## Usage

Add `#import "DYFKeychain.h"` to your source code.

#### String values

```objc
DYFKeychain *keychain = [DYFKeychain createKeychain];
[keychain add:@"User Account Passcode" forKey:@"kUserAccPasscode"];
NSString *s = [keychain get:@"kUserAccPasscode"];
```

#### Data values

```objc
DYFKeychain *keychain = [DYFKeychain createKeychain];
[keychain addData:data forKey:@"kCommSecureCode"];
NSData *data = [keychain getData:@"kCommSecureCode"];
```

#### Boolean values

```objc
DYFKeychain *keychain = [DYFKeychain createKeychain];
[keychain addBool:YES forKey:@"kFirstInstalledAndLaunched"];
BOOL ret = [keychain getBool:@"kFirstInstalledAndLaunched"];
```

#### Removing keys from Keychain

```objc
DYFKeychain *keychain = [DYFKeychain createKeychain];
[keychain delete:@"kFirstInstalledAndLaunched"]; // Remove single key.
[keychain clear]; // Delete everything from app's Keychain. Does not work on macOS.
```


## Advanced options

#### Keychain item access

Use `options` parameter to specify the security level of the keychain storage. By default the `DYFKeychainAccessOptionsAccessibleWhenUnlocked` option is used. It is one of the most restrictive options and provides good data protection.

```objc
DYFKeychain *keychain = [DYFKeychain createKeychain];
[keychain add:@"xxx" forKey:@"Key1" options:DYFKeychainAccessOptionsAccessibleWhenUnlocked];
```

You can use `DYFKeychainAccessOptionsAccessibleAfterFirstUnlock` if you need your app to access the keychain item while in the background. Note that it is less secure than the `DYFKeychainAccessOptionsAccessibleAfterFirstUnlock` option.

See the list of all available [access options](https://github.com/chenxing640/DYFKeychain/blob/master/Keychain/DYFKeychain.h).


#### Synchronizing keychain items with other devices

Set `synchronizable` property to `YES` to enable keychain items synchronization across user's multiple devices. The synchronization will work for users who have the "Keychain" enabled in the iCloud settings on their devices.

Setting `synchronizable` property to `YES` will add the item to other devices with the `add` method and obtain synchronizable items with the `get` command. Deleting a synchronizable item will remove it from all devices.

Note that you do not need to enable iCloud or Keychain Sharing capabilities in your app's target for this feature to work.

```objc
// The first device
DYFKeychain *keychain = [DYFKeychain createKeychain];
keychain.synchronizable = YES;
[keychain add:@"See you tomorrow!" forKey:@"key12"];

// The second device
DYFKeychain *keychain = [DYFKeychain createKeychain];
keychain.synchronizable = YES;
[keychain get:@"key12"];
```

We could not get the Keychain synchronization work on macOS.


#### Sharing keychain items with other apps

In order to share keychain items between apps on the same device they need to have common *Keychain Groups* registered in *Capabilities > Keychain Sharing* settings. There are online tutorials shows how to set it up.

Use `accessGroup` property to access shared keychain items. In the following example we specify an access group "9ZU3R2F3D4.com.omg.myapp.KeychainGroup" that will be used to set, get and delete an item "key1".

```objc
DYFKeychain *keychain = [DYFKeychain createKeychain];
keychain.accessGroup = @"9ZU3R2F3D4.com.omg.myapp.KeychainGroup" // Use your own access group.

[keychain add:@"hello world!" forKey:@"key12"];
[keychain get:@"key12"];
[keychain delete:@"key12"];
[keychain clear];
```

*Note*: there is no way of sharing a keychain item between the watchOS 2.0 and its paired device: https://forums.developer.apple.com/thread/5938


#### Check if operation was successful

You can verify if `add`, `delete` and `clear` methods finished successfully by checking their return values. Those methods return `YES` on success and `NO` on error.

```objc
DYFKeychain *keychain = [DYFKeychain createKeychain];

if ([keychain add:@"xxx" forKey:@"key1"]) {
  // Keychain item is saved successfully
} else {
  // Report error
}
```

To get a specific failure reason use the `osStatus` property containing result code for the last operation. See [Keychain Result Codes](https://developer.apple.com/documentation/security/1542001-security_framework_result_codes).

```objc
DYFKeychain *keychain = [DYFKeychain createKeychain];

[keychain add:@"xxx" forKey:@"key1"];
if (keychain.osStatus != errSecSuccess) { /* Report error */ }
```


#### Returning data as reference

Use the `asReference: YES` parameter to return the data as reference, which is needed for [NEVPNProtocol](https://developer.apple.com/documentation/networkextension/nevpnprotocol).

```objc
DYFKeychain *keychain = [DYFKeychain createKeychain];

[keychain addData:data forKey:@"key1"];
[keychain getData:@"key1" asReference:YES];
```


## Demo

`DYFKeychain` is learned how to use under this [Demo](https://github.com/chenxing640/DYFStoreKit/blob/master/DYFStoreKit/DYFStoreKeychainPersistence.m).


## Feedback is welcome

If you notice any issue, got stuck to create an issue. I will be happy to help you.

