# MediaBrix-iOS
![Cocoapods](https://img.shields.io/badge/pod-1.8.0.029-blue.svg)

## Installation with CocoaPods

```bash
$ gem install cocoapods
```

#### Podfile

To integrate MediaBrix into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/mediabrix/MediaBrixPods.git'
platform :ios, '7.0'

target 'TargetName' do
pod 'MediaBrix'
end
```

Then, run the following command:

```bash
$ pod install
```

####iOS 7
MediaBrix ads display fullscreen ads that hide the status bar. To ensure fullscreen mode in iOS 7, ensure that `preferStatusBarHidden` is set to `NO` or return the MediaBrix view controller in `childViewControllerForStatusBarHidden.`

####iOS 9 
The MediaBrix SDK requires ATS to be disabled. To disable ATS you will need to add the following key and value in your project's info.plist:

![](http://knowledge.mediabrix.com/userfiles/803/1179/ckfinder/images/ATS.PNG?dc=201509302214-16)



##Implementing the MediaBrix SDK

Include the following import and dictionary in your class' header file. 
```
#import "MediaBrix.h"
 
@interface ExampleViewController : UIViewController {
}
 
/* property for storing publisher vars from MediaBrix user defaults */
@property(strong,nonatomic) NSMutableDictionary * publisherVars;
 
@end
```

###Initialization

To initialize the MediaBrix SDK you will need to create an instance of the MediaBrix object:
```
[MediaBrix initMediaBrixAdHandler:self withBaseURL:@"http://mobile.mediabrix.com/v2/manifest" withAppID:@"APP_ID"]; // Replace APP_ID with the app id provided to you by MediaBrix 
//self refers to the UIViewController that is implementing the SDK
``` 

###Load an Ad
Once you received the kMediaBrixStarted callback, you will now be able to load ads. To load ads call the method below: 
``` 
publisherVars = [[MediaBrix userDefaults] defaultAdData].mutableCopy;
[[MediaBrix sharedInstance]loadAdWithIdentifier:@"Zone_Name" adData:publisherVars withViewController:self];
//self refers to the UIViewController that is implementing the SDK.
//if you do not have a reference to the UIViewController you can pass null.
``` 

###Show an Ad
Once you receive the notification `kMediaBrixAdReadyNotification`, you can show an ad for the zone that the `adIdentifier` returns.
````
[[MediaBrix sharedInstance]showAdWithIdentifier:@"Zone_Name" fromViewController:self reloadWhenFinish:NO];
//self refers to the UIViewController that is implementing the SDK.
// if you do not have a reference to the UIViewController you can pass null.
````

###SDK Delegate Methods
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

###Example

To view an example implementation click [here](https://github.com/mediabrix/mediabrix-ios-sdk/blob/master/Sample%20Project%20Obj%20C/Sample%20Project/ViewController.m)
