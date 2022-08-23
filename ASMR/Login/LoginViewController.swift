//
//  LoginViewController.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
   
    
    @IBOutlet weak var errorMsg: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginTapped(_ sender: Any){
        validateFields()
    }
    
    @IBAction func createTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "signUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func validateFields(){
        if emailTextField.text?.isEmpty == true {
            errorMsg.text = "You have not enter your email"
            errorMsg.textAlignment = .center;
            errorMsg.textColor = .red
            return
        }
        
        if passwordTextField.text?.isEmpty == true {
            errorMsg.text = "You have not enter your password"
            errorMsg.textAlignment = .center;
            errorMsg.textColor = .red
            return
        }
        
        login()
    }
    
    func login(){
        Firebase.Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {[weak self] authResult, err in
            guard let stronfSelf = self else{return}
            if let err = err{
                self!.errorMsg.textAlignment = .center
                self!.errorMsg.textColor = .red
                self!.errorMsg.text = err.localizedDescription
                print(err.localizedDescription)
                return
            }
            self?.checkUserInfo()
        }
    }
    
    func checkUserInfo() {
        if Firebase.Auth.auth().currentUser != nil{
            print(Firebase.Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "mainHome")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
}
