//
//  SignUpViewController.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var errorMsg: UITextView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var reEnterPassword: UITextField!
    
    static var passEmail = "123"
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        errorMsg.textAlignment = .center;
        errorMsg.textColor = .red
        
    }
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    @IBAction func signUpTapped(_ sender: Any) {
        if email.text?.isEmpty == true {
       
            errorMsg.text = "You have not enter your email"
            
            
            return
        }
        if password.text?.isEmpty == true{
            errorMsg.text = "You have not enter your password"
            return
        }
        
        if reEnterPassword.text?.isEmpty == true{
            errorMsg.text = "You have not reenter your password"
            return
        }
        
        if password.text == reEnterPassword.text
        {
           
        } else {
            errorMsg.text = "Passwords are not matched"
            return
        }
        
        
        
        
        signUp()
    }
    
    
    @IBAction func alreadyHave(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func signUp(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { [self] (authResult, error) in
            guard let user = authResult?.user, error == nil else{
                print("Error \(error?.localizedDescription) ")
                
                errorMsg.text = error?.localizedDescription
                return
            }
            
            let storyboard = UIStoryboard(name:"Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "signUp2")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            
        }
        print(email.text!)
        SignUpViewController.passEmail = email.text!
    }
}
