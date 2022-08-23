//
//  EmotionResult.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import Foundation
import UIKit
import UIKit
import FirebaseAuth
import FirebaseDatabase
class EmotionResult: UIViewController{

    @IBOutlet var showResult: UITextView!

    @IBOutlet weak var askchangeornot: UITextView!
    override func viewDidLoad() {
        
        showResult.textAlignment = .center
        var ref:DatabaseReference!
        ref = Database.database().reference()
        var counts: [String: Int] = [:]
        super.viewDidLoad()
        showResult.text = EmoViewController.datected
        

           let date = Date()
               let formatter = DateFormatter()
               formatter.dateFormat = "HH:mm:ss"
        let storeDate: String = formatter.string(from: date)
        let uid = Auth.auth().currentUser?.uid
        let obj: [String: Any] = [
            "ASMRCat": ASMRmenu.getASMRCat as NSString,
            "emotion": EmoViewController.datected as NSString
        ]
       
        ref.child("EmotionData").child(uid!).child(storeDate).updateChildValues(obj)
        if showResult.text == "happy"{
            askchangeornot.text = "It seems that the playlist suits you very much 😍, continue watching to minimize your stress level"
        } else if showResult.text == "neutral"{
            
            askchangeornot.text = "It seems that the playlist does not take much effect on you 😕. We suggest you continue watching for a longer period of time or switching to another category that interests you."
        } else {
            askchangeornot.text = "It seems that the playlist does not suits you very much 🙁. Please consider switching to another category that interests you."
        }
    }

  
    @IBAction func doneBtn(_ sender: Any) {
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "mainHome")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
        
    }



