//
//  signUpVC.swift
//  Firebase Instagram Clone
//
//  Created by Atıl Samancıoğlu on 30/01/2017.
//  Copyright © 2017 Atıl Samancıoğlu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class signUpVC: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: usernameText.text!, password: passwordText.text!, completion: { (user, error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    
                    
                    UserDefaults.standard.set(user!.email, forKey: "usersigned")
                    UserDefaults.standard.synchronize()
                    
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    delegate.rememberLogin()
                }
                
            })
            
        }
        
        
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: usernameText.text!, password: passwordText.text!, completion: { (user, error) in
                
                if error != nil {
                    
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                
                } else {
                   
                    UserDefaults.standard.set(user!.email, forKey: "usersigned")
                    UserDefaults.standard.synchronize()
                    
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    delegate.rememberLogin()
                    
                }
            })
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Provide an E-Mail & A Password", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}
