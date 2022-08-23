//
//  SignUp3ViewController.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class SignUp3ViewController: UIViewController {
    var ref:DatabaseReference!
  
    @IBOutlet weak var chooseStart: UIDatePicker!
    let datePicker = UIDatePicker()
   
    @IBOutlet weak var chooseLunch: UIDatePicker!
    @IBOutlet weak var jobTitle: UITextField!
    
    @IBOutlet weak var chooseEnd: UIDatePicker!
    @IBOutlet weak var startTime: UITextField!

    @IBOutlet weak var errorMsg: UITextView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var lunchTime: UITextField!

    override func viewDidLoad() {
        errorMsg.textColor = .red
        errorMsg.textAlignment = .center
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)

        ref = Database.database().reference()
        view.addSubview(doneBtn)
        
        doneBtn.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)

    }
    @objc private func addNewEntry(){

        
        
        
            
    let uid = Auth.auth().currentUser?.uid
    let obj: [String: Any] = [
        "jobTitle": jobTitle.text! as NSString,
        "startTime": startTime.text! as NSString,
        "endTime": endTime.text! as NSString,
        "lunchTime": lunchTime.text! as NSString]
    ref.child("JobInfo").child(uid!).setValue(obj)
    }
    
    @IBAction func startTimePicker(_ sender: Any) {
        let dateValue = DateFormatter()
        dateValue.dateFormat = "HHmm"
        startTime.text = dateValue.string(from: chooseStart.date)
    }
    
    @IBAction func lunchTimePicker(_ sender: Any) {
        let dateValue = DateFormatter()
        dateValue.dateFormat = "HHmm"
        lunchTime.text = dateValue.string(from: chooseLunch.date)
    }
    
    @IBAction func endTimePicker(_ sender: Any) {
        let dateValue = DateFormatter()
        dateValue.dateFormat = "HHmm"
        endTime.text = dateValue.string(from: chooseEnd.date)
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        if jobTitle.text == "" {
            errorMsg.text = "Please input your job Title."
            return
        }
        if startTime.text == "" {
            errorMsg.text = "Please input your start time."
            return
        }
        if lunchTime.text == "" {
            errorMsg.text = "Please input your lunch time."
            return
        }
        if endTime.text == "" {
            errorMsg.text = "Please input your end time."
            return
        }
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "mainHome")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @objc func dismissKeyboard() {
       
        view.endEditing(true)
    }
  
}
