//
//  ViewController.m
//  Muhammad's Sample App
//
//  Created by Muhammad Zubair on 3/24/16.
//  Copyright © 2016 Muhammad Zubair. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    [MediaBrix initMediaBrixAdHandler:self withBaseURL:@"http://mobile.mediabrix.com/v2/manifest" withAppID:@"TwwvxoFnJn"];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self loadAd];

    
}
-(void)loadAd{
    self.publisherVars = [[MediaBrix userDefaults] defaultAdData].mutableCopy;
    [[MediaBrix sharedInstance]loadAdWithIdentifier:@"Babel_Rally" adData:self.publisherVars withViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)test{
    

    [[MediaBrix sharedInstance]showAdWithIdentifier:@"Babel_Rally" fromViewController:self reloadWhenFinish:NO];

}
- (void)mediaBrixAdHandler:(NSNotification *)notification {
    
    /* implement the "mediaBrixAdHanlder" function for notifications (Required) */
    
    if([kMediaBrixAdWillLoadNotification isEqualToString:notification.name]){
        
        /* invoked when the ad has been requested */
        
    }
    else if([kMediaBrixAdFailedNotification isEqualToString:notification.name]){
        
        
        /* invoked whne ad failure occurs */
    }
    else if([kMediaBrixAdReadyNotification isEqualToString:notification.name]){
      
        //[[MediaBrix sharedInstance]showAdWithIdentifier:@"IOS_Rescue" fromViewController:self reloadWhenFinish:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            // do work here
            
            [[MediaBrix sharedInstance]showAdWithIdentifier:@"Babel_Rally" fromViewController:self reloadWhenFinish:NO];
        });
//
        /* invoked when ad has succesfully downloaded and ready for showing */
    }
    else if([kMediaBrixAdShowNotification isEqualToString:notification.name]){
        
        /* invoked when ad is presented */
        
    }
    else if([kMediaBrixAdDidCloseNotification isEqualToString:notification.name]){
        
        /* invoked when ad is closed */
    }
    else if([ kMediaBrixAdRewardNotification isEqualToString:notification.name]){
        
        /* invoked when ad view is completed and reward can be given */
    }
    
}

@end
