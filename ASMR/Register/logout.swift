//
//  logout.swift
//  ASMR
//
//  Created by Ying Nam lee on 31/3/2021.
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
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
    }
    
    
}
