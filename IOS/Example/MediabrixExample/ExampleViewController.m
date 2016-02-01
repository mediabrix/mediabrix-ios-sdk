//
//  ExampleViewController.m
//  MediaBrixExample
//
//  Created by MediaBrix
//  Copyright (c) 2012 MediaBrix inc. All rights reserved.
//

#import "ExampleViewController.h"
#import "AppDelegate.h"

#define PREFIX_RELOAD @"Reload"
#define PREFIX_SHOW @"Show"
#define PREFIX_LOADING @"Loading"

/*
static NSString* const myFlexIdentifier = @"QA_iOS_Flex";
static NSString* const myViewsIdentifier = @"QA_iOS_Views";
static NSString* const myRewardsIdentifier = @"QA_iOS_Rewards";
 */

static NSString* const myFlexIdentifier = @"IOS_Rally";
static NSString* const myViewsIdentifier = @"Android_Rescue";
static NSString* const myRewardsIdentifier = @"iOS_Rewards";

@interface ExampleViewController ()
@end

@implementation ExampleViewController

@synthesize status;
@synthesize socialFlexButton;
@synthesize socialViewsButton;
@synthesize  publisherVars;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [MediaBrix initMediaBrixAdHandler:self withBaseURL:@"http://mobile.mediabrix.com/v2/manifest" withAppID:@"tAefPGlpJKPVtQGoEBpp"];
    
    NSLog(@"MediaBrix Version: %@-%@",[MediaBrix version],[MediaBrix buildVersion]);
    

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    self.versionLabel.text = [NSString stringWithFormat:@"Medabrix - %@.%@", [MediaBrix version],[MediaBrix buildVersion]];
    [self.socialFlexButton setHidden:YES];
    [self.rewardsButton setHidden:YES];
    [self.socialViewsButton setHidden:YES];
	   
    NSString* buildDate = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"BuildDate"];
   
    if (buildDate)
    {
        self.titleLabel.text = [NSString stringWithFormat:@"Build: %@", buildDate];
    }

    NSString* appID = [[MediaBrix userDefaults] appID];
	NSURL* serverURL = [[MediaBrix userDefaults] baseURL];
	
    
	NSString* infoStr = [NSString stringWithFormat:@"Server: %@\nAppID: %@", serverURL.host, appID];
    
	self.infoLabel.text = infoStr;
    
   publisherVars = [[MediaBrix userDefaults] defaultAdData].mutableCopy;
    

    NSLog(@"publisherVars: %@",publisherVars);
    [publisherVars setObject:@"false" forKey:@"useMBbutton"];
    
  // [[MediaBrix sharedInstance]loadAdWithIdentifier:myFlexIdentifier adData:publisherVars withViewController:self];
    
//[[MediaBrix sharedInstance]loadAdWithIdentifier:myViewsIdentifier adData:publisherVars withViewController:self];

  [[MediaBrix sharedInstance]loadAdWithIdentifier:myRewardsIdentifier adData:publisherVars withViewController:self];

}
- (void)mediaBrixAdHandler:(NSNotification *)notification {
    
    
    NSLog(@"MediaBrix AdReady = %@,%@",notification.userInfo,notification.name);
    
    NSString * adIdentifier =[notification.userInfo objectForKey:kMediabrixTargetAdTypeKey];
    

    if([kMediaBrixAdWillLoadNotification isEqualToString:notification.name]){
        
        [self adWllLoad:adIdentifier];
        
    }
    else if([kMediaBrixAdFailedNotification isEqualToString:notification.name]){
        
        
        [self adFail:adIdentifier];
        
    }
    else if([kMediaBrixAdReadyNotification isEqualToString:notification.name]){
        

        [self adReady:adIdentifier];
        
    }
    else if([kMediaBrixAdShowNotification isEqualToString:notification.name]){
        
    }
    else if([kMediaBrixAdDidCloseNotification isEqualToString:notification.name]){
        
       
         [self adClose:adIdentifier];
        
    }
    else if([ kMediaBrixAdRewardNotification isEqualToString:notification.name]){
        
        [self adReward:adIdentifier];
        
    }
   
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return (UIInterfaceOrientationMaskAll);
}

#pragma mark AdHandlerDelegate
-(UIButton*)buttonForIdentifier:(NSString*)adIdentifier {
    
    UIButton* button = nil;
    if ([adIdentifier isEqualToString:myFlexIdentifier]) {
        button = self.socialFlexButton;
    } else if([adIdentifier isEqualToString:myViewsIdentifier]) {
        button = socialViewsButton;
    } else if([adIdentifier isEqualToString:myRewardsIdentifier]) {
        button = self.rewardsButton;
    }
    return button;
}

-(void)adWllLoad:(NSString*)adIdentifier{
    
    
    UIButton* button = [self buttonForIdentifier:adIdentifier];
    [button setEnabled:NO];
    [button setHidden:NO];
    [button setEnabled:NO];
    
    // move back to the actual name of the target:
    [button setTitle:[NSString stringWithFormat:@"%@ %@",PREFIX_LOADING,adIdentifier]
            forState:UIControlStateNormal];
}
-(void)adClose:(NSString*)adIdentifier{
        
        UIButton* button = [self buttonForIdentifier:adIdentifier];
        // move back to the actual name of the target:
        
        [button setTitle:[NSString stringWithFormat:@"%@ %@",PREFIX_RELOAD,adIdentifier]
                forState:UIControlStateNormal];
        [button setHidden:NO];
        [button setEnabled:YES];
}
-(void)adReward:(NSString*)adIdentifier{
    
    NSLog(@"MediaBrix Ad Reward for Identifier: %@",adIdentifier);
    
}



-(void)adFail:(NSString*)adIdentifier{
    
    
    UIButton* button = [self buttonForIdentifier:adIdentifier];
    // move back to the actual name of the target:
    [button setTitle:[NSString stringWithFormat:@"%@ %@",PREFIX_RELOAD,adIdentifier]
            forState:UIControlStateNormal];
    [button setHidden:NO];
    [button setEnabled:YES];
}

-(void)adReady:(NSString*)adIdentifer{
    
    
    UIButton* button = [self buttonForIdentifier:adIdentifer];
    [button setHidden:NO];
    [button setEnabled:YES];
    
    // move back to the actual name of the target:
    
    [button setTitle:[NSString stringWithFormat:@"%@ %@",PREFIX_SHOW,adIdentifer]
            forState:UIControlStateNormal];
}

#pragma mark actions

- (void)setLabel:(NSString *)text
{
    [self.status setText:text];
}

- (IBAction)loadMediaBrixAd:(id)sender{
    
    
    UIButton * selectedBtn =(UIButton*)sender;
    
    NSString * buttonTitle =selectedBtn.currentTitle;

    
    NSArray * adIdentfiers =[[NSArray alloc]initWithObjects:myFlexIdentifier,myViewsIdentifier,myRewardsIdentifier,nil];

    NSString * identifierName =[adIdentfiers objectAtIndex:selectedBtn.tag];
    

    if([buttonTitle hasPrefix:PREFIX_RELOAD]){
        
         [[MediaBrix sharedInstance]loadAdWithIdentifier:identifierName adData:publisherVars withViewController:self];
    }
    else{
        
        [[MediaBrix sharedInstance]showAdWithIdentifier:identifierName fromViewController:self reloadWhenFinish:NO];
        
    }
}

- (void)viewDidUnload {

    [super viewDidUnload];
    
    [MediaBrix removeMediaBrixObserver:self];
}
@end
