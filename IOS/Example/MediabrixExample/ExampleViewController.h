//
//  ExampleViewController.h
//  MediaBrixExample
//
//  Created by MediaBrix
//  Copyright (c) 2012 MediaBrix inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MediaBrix.h"
#import "AdConfiguratoinViewController.h"

@interface ExampleViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UIButton *socialFlexButton;
@property (strong, nonatomic) IBOutlet UIButton *socialViewsButton;
@property (strong, nonatomic) IBOutlet UIButton *rewardsButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UIButton *customizeButton;
@property(strong,nonatomic) NSMutableDictionary * publisherVars;


- (IBAction)loadMediaBrixAd:(id)sender;


@end

