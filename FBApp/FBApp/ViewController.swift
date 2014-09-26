//
//  ViewController.swift
//  FBApp
//
//  Created by Rajesh Segu on 9/24/14.
//  Copyright (c) 2014 500miles. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBLoginViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if(FB.hasActiveSession()){
            println("FACEBOOK ACTIVE SESSION");
        }else{
            println("FACEBOOK DOES NOT HAVE ACTIVE SESSION");
        }
        
        var loginView: FBLoginView = FBLoginView();
        loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 5);
        self.view.addSubview(loginView);
        
        loginView.delegate = self;
        
        loginView.sizeToFit();
        
    }
    
    @IBAction func facebookLogin(){
        FB.login(self.handleLogin);        
    }
    
    func handleLogin(){
        println("SUCCESS");
        FB.getInfo();
    }
    
    
}

