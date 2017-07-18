# MediaBrix-iOS

## Please see "Testing / Release Settings" section for new guidelines on testing and deploying your integration.

![Cocoapods](https://img.shields.io/badge/pod-1.8.1.000-blue.svg)

## Installation with CocoaPods

```bash
$ gem install cocoapods
```

#### Podfile

To integrate MediaBrix into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/mediabrix/mediabrix-cocoapods-spec.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'MediaBrix'
end
```

Then, run the following command:

```bash
$ pod install
```

#### iOS 9 & 10 
The MediaBrix SDK is now App Transport Security compliant. If you run into any issues when ATS is enabled, please email us at support@mediabrix.com immediately. 

If you do not wish to enable ATS at this time, you may disable it by adding the following key and value in your project's info.plist:

![](http://knowledge.mediabrix.com/userfiles/803/1179/ckfinder/images/ATS.PNG?dc=201509302214-16)



## Implementing the MediaBrix SDK

Include the following import and dictionary in your class' header file. Please ensure the ViewController that implements the MediaBrix SDK conforms to the MediaBrixDelegate protocol.
```
#import "MediaBrix.h"
 
@interface ExampleViewController : UIViewController <MediaBrixDelegate> {
}
 
/* property for storing publisher vars from MediaBrix user defaults */
@property(strong,nonatomic) NSMutableDictionary * publisherVars;
 
@end
```

### Initialization

To initialize the MediaBrix SDK you will need to create an instance of the MediaBrix object:
```
[MediaBrix initMediaBrixDelegate:self withBaseURL:@"https://mobile.mediabrix.com/v2/manifest" withAppID:@"APP_ID"]; // Replace APP_ID with the app id provided to you by MediaBrix 
//self refers to the UIViewController that is implementing the SDK
``` 

### Testing / Release Settings

To facilitate integrations and QA around the globe, MediaBrix has deployed an open Base URL for all of our world wide network partners to use while testing the MediaBrix SDK. This Test Base URL will eliminate the need for proxying your device to the US and ensure your app receives 100% fill during testing.

* **Test Base URL:** `https://test-mobile.mediabrix.com/v2/manifest/`

* **Production Base URL:** `https://mobile.mediabrix.com/v2/manifest/`

`https://test-mobile.mediabrix.com/v2/manifest/` should **ONLY** be used for testing purposes, as it will not deliver live campaigns to your app.

It is important to ensure that after testing, the Release build of your app uses the Production Base URL. **If you release your app using the Test Base URL, your app will not receive payable MediaBrix ads.**

### Load an Ad
Once you received the kMediaBrixStarted callback, you will now be able to load ads. To load ads call the method below: 
``` 
[[MediaBrix sharedInstance]loadAdWithIdentifier:@"Zone_Name" withViewController:self];
//self refers to the UIViewController that is implementing the SDK.
//if you do not have a reference to the UIViewController you can pass nil.
``` 

### Show an Ad
Once you receive the notification `kMediaBrixAdReadyNotification`, you can show an ad for the zone that the `adIdentifier` returns.
````
[[MediaBrix sharedInstance]showAdWithIdentifier:@"Zone_Name" fromViewController:self reloadWhenFinish:NO];
//self refers to the UIViewController that is implementing the SDK.
// if you do not have a reference to the UIViewController you can pass nil.
````

### SDK Delegate Methods
You will need to receive delegate callbacks from the SDK when loading/showing an ad. The code below shows the various delegate callback methods from the SDK. 
``` 
/* Required */
-(void)mediaBrixStarted {
    //Invoked when the sdk has been initialized
}
-(void)mediaBrixAdReady:(NSString *)identifier {
    // Invoked when ad has succesfully downloaded and is ready to show
}

/* Optional */
- (void)mediaBrixAdWillLoad:(NSString *)identifier {
    // Invoked when the ad has been requested 
}
- (void)mediaBrixAdFailed:(NSString *)identifier {
    // Invoked when the ad fails to load an ad
}
- (void)mediaBrixAdShow:(NSString *)identifier {
    // Invoked when ad is being shown to the user
}
- (void)mediaBrixAdDidClose:(NSString *)identifier {
    // Invoked when the ad is closed
}
- (void)mediaBrixAdReward:(NSString *)identifier {
    // Invoked when the user has watched an ad that offers an incentive and reward should be given
}
- (void)mediaBrixAdClicked:(NSString *)identifier {
    // Invoked when the user has clicked the ad
}   
```
### Logging
You can now disable verbose logging via the SDK:
```
    [MediaBrix MBEnableVerboseLogging:NO];
```
### Bitcode
The Receptiv SDKs v1.8.0.050 and up support bitcode. Current versions that support bitcode:
 * 1.8.0.050
 * 1.8.1.000


### Example

To view an example implementation click [here](https://github.com/mediabrix/mediabrix-ios-sdk/blob/master/Sample%20Project%20Obj%20C/Sample%20Project/ViewController.m)
