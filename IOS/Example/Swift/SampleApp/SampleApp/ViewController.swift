//
//  ViewController.swift
//  SampleApp
//
//  Created by Punnaghai Puviarasu on 4/26/16.
//  Copyright © 2016 Punnaghai Puviarasu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var publisherVar:[AnyHashable: Any] = [AnyHashable: Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Initialize mediabix event handler with the base url & the mediabrix provided app_id.
        MediaBrix.initMediaBrixDelegate(self, withBaseURL: "http://mobile.mediabrix.com/v2/manifest", withAppID: "TwwvxoFnJn")
        
        //initialize te publishervariables dictionary
        publisherVar = MediaBrix.userDefaults().defaultAdData()
        
        //load the ad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAd(){
        MediaBrix.sharedInstance().showAd(withIdentifier: "Babel_Rally", from: self, reloadWhenFinish: false)
    }
    func loadAd() {
        MediaBrix.sharedInstance().loadAd(withIdentifier: "Babel_Rally", adData: publisherVar, with: self)
    }
    
}

extension ViewController: MediaBrixDelegate {
    public func mediaBrixAdReady(_ identifier: String!) {
        self.showAd()
    }
    func mediaBrixStarted() {
        self.loadAd()
    }
}


