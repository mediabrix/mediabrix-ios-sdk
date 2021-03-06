//
//  ViewController.m
//  Sample Project
//
//  Created by Muhammad Zubair on 5/5/16.
//  Copyright © 2016 MediaBrix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <MediaBrixDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MediaBrix initMediaBrixDelegate:self withBaseURL:@"http://mobile.mediabrix.com/v2/manifest" withAppID:@"TwwvxoFnJn"];
    [self loadAd];

}

-(void)loadAd{
    [[MediaBrix sharedInstance]loadAdWithIdentifier:@"Babel_Rescue" withViewController:self];
}

-(void)showAd {
    [[MediaBrix sharedInstance]showAdWithIdentifier:@"Babel_Rescue" fromViewController:self reloadWhenFinish:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MediaBrixDelegate

-(void)mediaBrixStarted {
    [self loadAd];
}
-(void)mediaBrixAdReady:(NSString *)identifier {
    [self showAd];
}

@end
