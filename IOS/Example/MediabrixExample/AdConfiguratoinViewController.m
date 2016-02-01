//
//  AdConfiguratoinViewController.m
//  MediabrixExample
//
//  Created by Amos Elmaliah on 7/10/13.
//  Copyright (c) 2013 MediaBrix. All rights reserved.
//

#import "AdConfiguratoinViewController.h"
#import "Mediabrix.h"
#import "AppDelegate.h"

@interface AdConfiguratoinViewController () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView* webView;
@end

@implementation AdConfiguratoinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
}

-(void)updateUI {

    NSMutableString* mutableHTML = [[NSMutableString alloc] init];

    [mutableHTML appendString:@"<form method=\"post\" action=\"/login\"><table>"];
    
    [self.configurations enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {

        NSString* htmlTag = [NSString stringWithFormat:
                             @"<TR>"
                             @"<TD>%@</TD>"
                             @"<TD><INPUT type=\"text\" value=\"%@\" name=\"%@\" title=\"%@\"/><TD></TR>"
                             @"<TR>", key, obj, key, key];
        [mutableHTML appendString:htmlTag];
    }];
    
    [mutableHTML appendString:@"<input type=\"submit\" value=\"Done\"></table></form>"];

    [self.webView loadHTMLString:[mutableHTML copy]
                         baseURL:nil];
    [self.webView setDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.onDismiss) {
        self.onDismiss(self);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) decodeFromPercentEscapeString:(NSString *) string {
    return [(__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                         (__bridge CFStringRef) string,
                                                                                         CFSTR(""),
                                                                                         kCFStringEncodingUTF8) stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([[request HTTPMethod] isEqualToString:@"POST"]) {
        
        NSString* body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        
        [[body componentsSeparatedByString:@"&"] enumerateObjectsUsingBlock:^(NSString* param, NSUInteger idx, BOOL *stop) {
            NSArray* params = [param componentsSeparatedByString:@"="];
            NSString* key = params[0];
            if (key && key.length) {
                NSString* object = [self decodeFromPercentEscapeString:params[1] ? : @""];
                if (key && object) {
                    [self.configurations setObject:object forKey:key];
                }
            }
        }];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
    return YES;
    
}
@end
