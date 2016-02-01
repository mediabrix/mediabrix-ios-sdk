//
//  AdConfiguratoinViewController.h
//  MediabrixExample
//
//  Created by Amos Elmaliah on 7/10/13.
//  Copyright (c) 2013 MediaBrix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdConfiguratoinViewController : UIViewController
@property (nonatomic, strong) NSMutableDictionary* configurations;
@property (nonatomic, copy) void(^onDismiss)(AdConfiguratoinViewController*);

@end
