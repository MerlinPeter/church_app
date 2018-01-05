//
//  LoginViewController.swift
//  spectrum
//
//  Created by Merlin Ahila on 6/22/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
import FirebaseAuth
 
class LoginViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "img.png")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
      
        
        passwordText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userNameText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    
            Auth.auth().addStateDidChangeListener() { auth, user in
                
                guard   user != nil  else {
                    return
                }
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "MainNavigation", sender: nil)
                }
  
        }
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        activityIndicator.startAnimating()
        // Auth.auth().sendPasswordReset(withEmail: <#T##String#>, completion: <#T##SendPasswordResetCallback?##SendPasswordResetCallback?##(Error?) -> Void#>)
        
        Auth.auth().signIn(withEmail: userNameText.text!, password: passwordText.text!) { (user, error) in
            //  self.performSegue(withIdentifier: "firstNavigation", sender: nil)
            if error != nil {
                /* guard let verified = user?.isEmailVerified , verified == false else {
                 
                 self.errorText.text = "User Email not verified, Please check your email for verification"
                 return
                 }*/
                
                if let error = error,
                    let errCode = AuthErrorCode(rawValue: error._code)
                {
                    switch errCode {
                    case .wrongPassword:
                        print( "Incorrect Password, to reset press Forget Password "  )
                    case .userNotFound :
                        print( "user not found  , to reset press Forget Password "  )

                    default :
                        print( "not sure what happend"  )
                    }
                }
            }
            self.passwordText.text = ""
            self.loginButton.isEnabled = false
            self.loginButton.alpha = 0.5
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

extension LoginViewController {
    
    func textFieldDidChange(_ textField: UITextField) {
        if let username = userNameText.text , let pwd = passwordText.text   {
            
            if !username.isEmpty && !pwd.isEmpty {
                loginButton.isEnabled = true
                loginButton.alpha = 1
            }
            if username.isEmpty || pwd.isEmpty {
                loginButton.isEnabled = false
                loginButton.alpha = 0.5
            }
        }
    }
}

