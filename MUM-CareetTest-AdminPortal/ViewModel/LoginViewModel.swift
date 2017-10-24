//
//  LoginViewModel.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/11/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit
class LoginViewModel: NSObject{
    @IBOutlet var webservice: webServiceClient!
    var userData: [NSDictionary]?

    
    func userAuthenticationResult(user: String,pwd: String,onCompletion: @escaping (Bool, Any?, Error?)-> Void){
        webservice.authenticateUser (usernamex: user,passwordx: pwd){
            (success,response,error) in
            if success{
                self.userData = response as? [NSDictionary]
                let userWasHere =  UserDefaults.standard
                userWasHere.set(user, forKey: KEY_USERNAME)
                print("LoginVC: data saved to keychain \(userWasHere)")
                print(response!)
                onCompletion(true,self.userData, nil)

            }else{
                onCompletion(false,nil, error)

                
            }
            
        }
    }
}
