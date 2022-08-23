//
//  logout.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import Foundation

import UIKit
import FirebaseAuth
import FirebaseDatabase
class logout: UIViewController {
    var ref:DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    @IBAction func noLogout(_ sender: Any) {
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "mainHome")
        vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
    }
    @IBAction func logoutBtn(_ sender: Any) {
        if Auth.auth().currentUser != nil {
                do {
                    try Auth.auth().signOut()
                    exit(0)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
    }
    
    
}
