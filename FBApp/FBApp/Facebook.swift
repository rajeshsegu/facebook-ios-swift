//
//  Facebook.swift
//  FBApp
//
//  Created by Rajesh Segu on 9/24/14.
//  Copyright (c) 2014 500miles. All rights reserved.
//

import Foundation

let FB = Facebook();

class Facebook {
    
    var fbSession:FBSession?;
    
    init(){
        self.fbSession = FBSession.activeSession();
    }
    
    func hasActiveSession() -> Bool{
        let fbsessionState = FBSession.activeSession().state;
        if ( fbsessionState == FBSessionState.Open
            || fbsessionState == FBSessionState.OpenTokenExtended ){
                self.fbSession = FBSession.activeSession();
                return true;
        }
        return false;
    }
    
    func login(callback: () -> Void){
        
        let permission = ["basic_info", "email", "user_work_history", "user_education_history", "user_location"];
        
        let activeSession = FBSession.activeSession();
        let fbsessionState = activeSession.state;
        var showLoginUI = true;
        
        if(fbsessionState == FBSessionState.CreatedTokenLoaded){
            showLoginUI = false;
        }
        
        if(fbsessionState != FBSessionState.Open
            && fbsessionState != FBSessionState.OpenTokenExtended){
                FBSession.openActiveSessionWithReadPermissions(
                    permission,
                    allowLoginUI: showLoginUI,
                    completionHandler: { (session:FBSession!, state:FBSessionState, error:NSError!) in

                        if(error != nil){
                            println("Session Error: \(error)");
                        }
                        
                        self.fbSession = session;
                        
                        callback();
                        
                    }
                );
                return;
        }
        
        callback();
        
    }
    
    func logout(){
        self.fbSession?.closeAndClearTokenInformation();
        self.fbSession?.close();
    }
    
    func getInfo(){
        FBRequest.requestForMe()?.startWithCompletionHandler({(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) in
            
            if(error != nil){
                println("Error Getting ME: \(error)");
            }
            
            println("\(result)");
            
            
        });
    }
    
    func handleDidBecomeActive(){
        FBAppCall.handleDidBecomeActive();
    }
    
}
