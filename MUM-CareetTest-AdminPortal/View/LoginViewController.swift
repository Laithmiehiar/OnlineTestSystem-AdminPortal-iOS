//
//  ViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/9/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    @IBOutlet var loginViewModel: LoginViewModel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forgetPasswordPressed(_ sender: Any) {
        
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        if let user = username.text, let pwd = password.text{
            loginViewModel.userAuthenticationResult(user: user,pwd: pwd){
                (success,response,error) in
                if success{
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "goToHomePage", sender: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                    self.alertDialogPopup(alertTitle: "Warning!", alertMessage: "please recheck on your email or password", buttonTitle: "Ok")
                    print("LoginViewController: authentication failed, please recheck your email or password")
                    }
                    
                }
            }
            
            
        }
        
    }
    
    func alertDialogPopup(alertTitle: String, alertMessage: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
