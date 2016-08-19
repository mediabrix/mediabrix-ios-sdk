//
//  ViewController.swift
//  SampleApp
//
//  Created by Punnaghai Puviarasu on 4/26/16.
//  Copyright © 2016 Punnaghai Puviarasu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var publisherVar:[NSObject:AnyObject] = [NSObject:AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Initialize mediabix event handler with the base url & the mediabrix provided app_id.
        MediaBrix.initMediaBrixAdHandler(self, withBaseURL: "http://mobile.mediabrix.com/v2/manifest", withAppID: "TwwvxoFnJn")
        
        //initialize te publishervariables dictionary
        publisherVar = MediaBrix.userDefaults().defaultAdData()
        
        //load the ad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAd(){
        MediaBrix.sharedInstance().showAdWithIdentifier("Babel_Rally", fromViewController: self, reloadWhenFinish: false)
    }
    
    //implement the notification handler thats is required to know when the ad asset download is complete & ad is ready for viewing
    func mediaBrixAdHandler(notification: NSNotification){
        
        print("MediaBrix notification = %@,%@",notification.userInfo,notification.name);
        if(kMediaBrixStarted == notification.name){
            MediaBrix.sharedInstance().loadAdWithIdentifier("Babel_Rally", adData: publisherVar, withViewController: self)
        }
        else if(kMediaBrixAdWillLoadNotification == notification.name){
            /* invoked when the ad has been requested */
        }
        else if(kMediaBrixAdFailedNotification == notification.name){
            
            /* invoked whne ad failure occurs */
        }
        else if(kMediaBrixAdReadyNotification == notification.name){
            
            /* invoked when ad has succesfully downloaded and ready for showing */
            
            dispatch_async(dispatch_get_main_queue(), {
                self.showAd()
            })
        }
        else if(kMediaBrixAdShowNotification == notification.name){
            
            /* invoked when ad is presented */
            
        }
        else if(kMediaBrixAdDidCloseNotification == notification.name){
            
            /* invoked when ad is closed */
            
        }
        else if(kMediaBrixAdRewardNotification == notification.name){
            
            /* invoked when ad view is completed and reward can be given */
            
        }
    }


}

