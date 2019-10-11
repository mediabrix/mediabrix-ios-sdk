#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreTelephony/CoreTelephonyDefines.h>
#import <UIKit/UIKit.h>

#define MEDIABRIX_1_5_5 [[Mediabrix version] hasPrefix:@"v1.5"]
#define MediaBrixSDK_MBUtils_h

// notifications:
extern NSString* const kMediaBrixStarted;
extern NSString* const kMediaBrixAdWillLoadNotification;
extern NSString* const kMediaBrixAdDidLoadNotification;
extern NSString* const kMediaBrixAdFailedNotification;
extern NSString* const kMediaBrixAdReadyNotification;
extern NSString* const kMediaBrixAdShowNotification;
extern NSString* const kMediaBrixAdDidCloseNotification;
extern NSString* const kMediaBrixAdRewardNotification;
extern NSString* const kMediaBrixAdClickedNotification;
extern NSString* const kMediaBrixFlex;
extern NSString* const kMediaBrixViews;
extern NSString* const kMediaBrixRewards;
extern NSString* const kMediabrixTargetAdTypeKey;
extern NSString* const kMediabrixTargetPropertyKey;
extern NSString* const kMediabrixTargetZoneKey;

@class AdHandlerAbstract;
@protocol AdHandlerDelegate <NSObject>
@optional
-(void)adHandler:(AdHandlerAbstract*)adHandler willChangeStatusForIdentifier:(NSString*)identifier;
-(void)adHandler:(AdHandlerAbstract*)adHandler didChangeStatusForIdentifier:(NSString*)identifier;
-(void)adHandler:(AdHandlerAbstract*)adHandler willLoadTargetIdentifier:(NSString*)adIdentifier;
-(void)adHandler:(AdHandlerAbstract*)adHandler didFinishLoadingAdWithIdenitifer:(NSString*)adIdentifier;
-(void)adHandler:(AdHandlerAbstract*)adHandler failedLoadingAdWithIdentifier:(NSString*)adIdentifier;
-(void)adHandler:(AdHandlerAbstract*)adHandler willShowAdWithIdentifier:(NSString*)adIdentifier;
-(void)adHandler:(AdHandlerAbstract*)adHandler didShowAdWithIdentifier:(NSString*)adIdentifier willReload:(BOOL)reload;
-(void)adHandler:(AdHandlerAbstract*)adHandler didReceiveRewardConfirmationForAdWithIdentifier:(NSString*)adIdentifier withAdData:(NSDictionary*)adData totalRewardsForThisAd:(NSUInteger)totalRewards;
@end

@protocol MediaBrixDelegate <NSObject>
@required
-(void)mediaBrixStarted;
-(void)mediaBrixAdReady:(NSString *)identifier;
@optional
-(void)mediaBrixAdReward:(NSString *)identifier;
-(void)mediaBrixAdWillLoad:(NSString *)identifier;
-(void)mediaBrixAdFailed:(NSString *)identifier;
-(void)mediaBrixAdShow:(NSString *)identifier;
-(void)mediaBrixAdDidClose:(NSString *)identifier;
-(void)mediaBrixAdClicked:(NSString *)identifier;
@end

@protocol MediaBrixAdViewController <NSObject>
-(void)showInViewController:(UIViewController *)controller;
@property (retain, nonatomic) NSDictionary *adData;
@property (retain, nonatomic, readonly) NSDictionary *target;
@end

@interface MediaBrix : NSObject
+(void) MBEnableVerboseLogging:(BOOL)verbose;
+(void)initMediaBrixDelegate:(id <MediaBrixDelegate>)delegate withBaseURL:(NSString*)baseURL withAppID:(NSString*)appID;
+(void)setMediaBrixAdHandlerData:(NSDictionary*)data;
+(void)removeMediaBrixObserver:(UIViewController*)viewController;
+(void)resetInstance;
+(NSString*)getBaseURL;
+(NSString*)version;
+(NSString*)buildVersion;
+(NSString*)getAppID;
+(MediaBrix*)sharedInstance;
-(void)loadAdWithIdentifier:(NSString*)adIdentifier withViewController:(UIViewController*)viewController;
-(void)showAdWithIdentifier:(NSString*)adIdentifier fromViewController:(UIViewController*)viewController reloadWhenFinish:(BOOL)isReload;
-(void)loadAdWithTarget:(NSDictionary*)target;
-(NSString*)adTypeForAd:(id)ad;
@property(nonatomic,strong) NSString * baseURL;
@property(nonatomic,strong) NSString * appID;
@end

#ifndef _SYSTEMCONFIGURATION_H
#error "The SystemConfiguration framework not found in project or not included in precompiled header, please make sure that it does"
#endif

#ifndef __UTTYPE__
#error "The MobileCoreServices framework not found in project or not included in precompiled header, please make sure that it does"
#endif

#ifndef CORETELEPHONY_EXTERN
#error "The CoreTelephony framework not found in project or not included in precompiled header, please make sure that it does"
#endif

