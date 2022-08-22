//
//  SignUpViewController.swift
//  ASMR
//
//  Created by Ying Nam lee on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class changeJob: UIViewController {
    var ref:DatabaseReference!
    let datePicker = UIDatePicker()
   
    @IBOutlet weak var chooseStart: UIDatePicker!
    @IBOutlet weak var chooseLunch: UIDatePicker!
    @IBOutlet weak var jobTitle: UITextField!

    @IBOutlet weak var chooseEnd: UIDatePicker!
    @IBOutlet weak var startTime: UITextField!

   
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var lunchTime: UITextField!
   
    
    @IBOutlet weak var doneBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)

        ref = Database.database().reference()
        view.addSubview(doneBtn)
        doneBtn.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
        //errorMsg.text = "You have not complete the form yet."
        //errorMsg.textAlignment = .center;
        //errorMsg.textColor = .red
        // Do any additional setup after loading the view.
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
        dismiss(animated: true, completion: nil)

//        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "settings")
//        vc.modalPresentationStyle = .fullScreen
//        vc.isModalInPresentation = true
//        self.present(vc, animated: true, completion: nil)
    }
   
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
  
}
