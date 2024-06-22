中文版 | [English Vision](README-en.md)


## DYFKeychain

在钥匙串中存储文本和数据([Swift Version](https://github.com/itenfay/DYFSwiftKeychain))。你可能已经注意到苹果的 Keychain API 有点冗长。此库旨在提供较短的语法完成简单任务：读取/写入指定键的文本值：

```objc
DYFKeychain *keychain = [DYFKeychain defaultKeychain];
[keychain add:@"User Account Passcode" forKey:@"kUserAccPasscode"];
NSString *p = [keychain get:@"kUserAccPasscode"];
```

此 Keychain 库包括以下功能：

- 获取、设置和删除字符串、布尔值和数据的钥匙串项。
- 指定项访问安全级别。
- 通过 iCloud 同步项。
- 与其他应用程序共享钥匙串项。

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;
[![CocoaPods Version](http://img.shields.io/cocoapods/v/DYFKeychain.svg?style=flat)](http://cocoapods.org/pods/DYFKeychain)&nbsp;
![CocoaPods Platform](http://img.shields.io/cocoapods/p/DYFKeychain.svg?style=flat)&nbsp;


## QQ群 (ID:614799921)

<div align=left>
&emsp; <img src="https://github.com/itenfay/DYFKeychain/raw/master/images/g614799921.jpg" width="30%" />
</div>


## 安装

使用 [CocoaPods](https://cocoapods.org):

``` 
pod 'DYFKeychain'
```

Or

```
pod 'DYFKeychain', '~> 1.2.0'
```

或者从 [Keychain](https://github.com/itenfay/DYFKeychain/tree/master/Keychain) 目录手动添加文件。


## 什么是 Keychain?

Keychain 是一种安全的存储方式。你可以在其中存储所有类型的敏感数据：用户密码、信用卡号码、秘密令牌等。一旦存储在 Keychain 中，这些信息只对你的应用可用，其他应用看不到。除此之外，操作系统确保这些信息被安全地保存和处理。例如，存储在 Keychain 中的文本不能从 iPhone 备份或其文件系统中提取。苹果建议只在 Keychain 中存储少量数据。如果你需要保护一些大的东西，你可以手动加密它，保存到一个文件，并将密钥存储在 Keychain 中。


## 使用

将 `#import "DYFKeychain.h"` 添加到源代码中。

### 写入/读取字符串

```objc
DYFKeychain *keychain = [DYFKeychain defaultKeychain];
[keychain add:@"User Account Passcode" forKey:@"kUserAccPasscode"];
NSString *s = [keychain get:@"kUserAccPasscode"];
```

### 写入/读取字节序列

```objc
DYFKeychain *keychain = [DYFKeychain defaultKeychain];
[keychain addData:data forKey:@"kCommSecureCode"];
NSData *data = [keychain getData:@"kCommSecureCode"];
```

### 写入/读取布尔值

```objc
DYFKeychain *keychain = [DYFKeychain defaultKeychain];
[keychain addBool:YES forKey:@"kFirstInstalledAndLaunched"];
BOOL ret = [keychain getBool:@"kFirstInstalledAndLaunched"];
```

### 从钥匙串移除数据

```objc
DYFKeychain *keychain = [DYFKeychain defaultKeychain];
[keychain delete:@"kFirstInstalledAndLaunched"]; // Remove single key.
[keychain clear]; // Delete everything from app's Keychain. Does not work on macOS.
```


## 高级选项

### 钥匙串项访问选项

使用 `options` 参数指定 Keychain 存储的安全级别。默认情况下使用 `DYFKeychainAccessOptionsAccessibleWhenUnlocked` 选项。它是限制性最强的选项之一，可以提供良好的数据保护。

```objc
DYFKeychain *keychain = [DYFKeychain defaultKeychain];
[keychain add:@"xxx" forKey:@"Key1" options:DYFKeychainAccessOptionsAccessibleWhenUnlocked];
```

如果需要应用程序在后台访问钥匙串项，则可以使用 `DYFKeychainAccessOptionsAccessibleAfterFirstUnlock`。请注意，它比 `DYFKeychainAccessOptionsAccessibleAfterFirstUnlock` 选项更不安全。

查看所有可用的 [访问选项](https://github.com/itenfay/DYFKeychain/blob/master/Keychain/DYFKeychain.h) 列表。


### 将钥匙串项与其他设备同步

将  `synchronizable` 属性设置为 `true` 可在用户的多个设备之间启用钥匙串项同步。同步将适用于在其设备上的 iCloud 设置中启用了 Keychain 的用户。

将 `synchronizable` 属性设置为 `true` 将使用 `add` 方法将该项添加到其他设备，并使用 `get` 命令获取可同步的项。删除可同步项将从所有设备中删除。

请注意，您不需要在应用程序的目标中启用 iCloud 或 Keychain 共享功能，使此功能工作。

```objc
// The first device
DYFKeychain *keychain = [DYFKeychain defaultKeychain];
keychain.synchronizable = YES;
[keychain add:@"See you tomorrow!" forKey:@"key12"];

// The second device
DYFKeychain *keychain = [DYFKeychain defaultKeychain];
keychain.synchronizable = YES;
[keychain get:@"key12"];
```

我们无法在 macOS 上进行钥匙串同步工作。


### 与其他应用程序共享钥匙串项

为了在同一设备上的应用程序之间共享钥匙串项，它们需要在*Capabilities > Keychain Sharing*设置中注册通用*Keychain Groups*。

使用 `accessGroup` 属性访问共享钥匙串项。在下面的示例中，我们指定一个访问组 `9ZU3R2F3D4.com.omg.myapp.KeychainGroup`，它将用于设置、获取和删除 `key1` 项。

```objc
DYFKeychain *keychain = [DYFKeychain defaultKeychain];
keychain.accessGroup = @"9ZU3R2F3D4.com.omg.myapp.KeychainGroup" // Use your own access group.

[keychain add:@"hello world!" forKey:@"key12"];
[keychain get:@"key12"];
[keychain delete:@"key12"];
[keychain clear];
```

*注*：watchOS 2.0与其配对设备之间无法共享钥匙串项：https://forums.developer.apple.com/thread/5938


### 检查操作是否成功

通过检查 `add`, `delete` 和 `clear` 方法的返回值，可以验证它们是否成功完成。这些方法成功时返回 `true`，出错时返回 `false`。

```objc
DYFKeychain *keychain = [DYFKeychain defaultKeychain];

if ([keychain add:@"xxx" forKey:@"key1"]) {
  // Keychain item is saved successfully
} else {
  // Report error
}
```

若要获取特定的失败原因，请使用包含上一个操作的结果代码的 `osStatus` 属性。请参见 [Keychain Result Codes](https://developer.apple.com/documentation/security/1542001-security_framework_result_codes)。

```objc
DYFKeychain *keychain = [DYFKeychain defaultKeychain];

[keychain add:@"xxx" forKey:@"key1"];
if (keychain.osStatus != errSecSuccess) { /* Report error */ }
```


### 数据引用返回

使用 `asReference: true` 参数将数据作为引用返回，这是 [NEVPNProtocol](https://developer.apple.com/documentation/networkextension/nevpnprotocol) 所需的。

```objc
DYFKeychain *keychain = [DYFKeychain defaultKeychain];

[keychain addData:data forKey:@"key1"];
[keychain getData:@"key1" asReference:YES];
```


## 演示

`DYFKeychain` 在此 [演示](https://github.com/itenfay/DYFStoreKit/blob/master/Classes/DYFStoreKeychainPersistence.m) 下学习如何使用。


## 欢迎反馈

如果您发现任何问题，请创建问题。我很乐意帮助你。
