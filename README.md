# MediaBrix-iOS

## Please see "Testing / Release Settings" section for new guidelines on testing and deploying your integration.

![Cocoapods](https://img.shields.io/badge/pod-1.8.3.001-blue.svg)

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

#### ATS on iOS 9, 10 & 11
The MediaBrix SDK requires an exception for App Transport Security for our ad request calls. Please add the following exception key and value dictionary to your project's info.plist:

```
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoadsInWebContent</key>
		<true/>
		<key>NSExceptionDomains</key>
		<dict>
			<key>pubads.g.doubleclick.net</key>
			<dict>
				<key>NSExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSIncludesSubdomains</key>
				<true/>
			</dict>
		</dict>
	</dict>
 ```

![](https://cdn.mediabrix.com/o38/devsupportportal/Apple_ATS_Instructions.png)



## Implementing the MediaBrix SDK

Include the following import and dictionary in your class' header file. Please ensure the ViewController that implements the MediaBrix SDK conforms to the MediaBrixDelegate protocol.
```
#import "MediaBrix.h"
 
@interface ExampleViewController : UIViewController <MediaBrixDelegate> {
}
@end
```

### Initialization

To initialize the MediaBrix SDK you will need to create an instance of the MediaBrix object:
```
[MediaBrix initMediaBrixDelegate:self withBaseURL:@"https://mobile.mediabrix.com/v2/manifest" withAppID:@"APP_ID"]; // Replace APP_ID with the app id provided to you by MediaBrix 
//self refers to the UIViewController that is implementing the SDK
``` 

### Testing Outside of the US

Due to changes to EU Law (GDPR), Verve video ads only display in the United States and Canada. For 100% fill when requesting ads outside of the US, we suggest you proxy to the US while testing your integration.

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
 * 1.8.2.001
 * 1.8.2.002


### Example

To view an example implementation click [here](https://github.com/mediabrix/mediabrix-ios-sdk/blob/master/Sample%20Project%20Obj%20C/Sample%20Project/ViewController.m)
