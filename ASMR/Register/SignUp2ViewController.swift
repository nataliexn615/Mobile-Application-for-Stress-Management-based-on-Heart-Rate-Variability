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


class SignUp2ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var chooseDate: UIDatePicker!

    var ref:DatabaseReference!
    static var getGender:String = ""
    static var getAge:Int = 0
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
  //  @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var gender: UISegmentedControl!
    
    @IBOutlet weak var showTry: UITextView!
    
    var vc = SignUpViewController()
    let datePicker = UIDatePicker()
  
    override func viewDidLoad() {
        showTry.textColor = .red
        showTry.textAlignment = .center
        super.viewDidLoad()
     //   createDatePicker()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

       //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
       //tap.cancelsTouchesInView = false

       view.addGestureRecognizer(tap)
        dateOfBirth.delegate = self
        let hehe = SignUpViewController.passEmail
        ref = Database.database().reference()
        view.addSubview(doneBtn)
        let text2 = SignUpViewController.passEmail.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
        print(text2)
        doneBtn.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
        //showTry.text = String(vc.email.text!)
        // Do any additional setup after loading the view.
     //  errorMsg.text = "You have not complete the form yet."
      //  errorMsg.textAlignment = .center;
      //  errorMsg.textColor = .red
    }

    @IBAction func dintbutton(_ sender: Any) {
        if name.text == "" {
            showTry.text = "Please input your name"
            return
        }
        if dateOfBirth.text == "" {
            showTry.text = "Please input your birthday"
            return
        }
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "SignUp3ViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func mydatePickerAction(_ sender: UIDatePicker) {
       
        let dateValue = DateFormatter()
        dateValue.dateFormat = "dd-MM-yyyy"
        dateOfBirth.text = dateValue.string(from: chooseDate.date)
    }
        
    @objc private func addNewEntry(){
        let uid = Auth.auth().currentUser?.uid
        //let object: [String: Any] = [
        //    "email": SignUpViewController.passEmail as NSString,]
        let title = gender.titleForSegment(at: gender.selectedSegmentIndex)
        let birthDate = chooseDate.date
              
              //2 - get today date
              let today = Date()
              
              //3 - create an instance of the user's current calendar
              let calendar = Calendar.current
              
              //4 - use calendar to get difference between two dates
              let components = calendar.dateComponents([.year], from: birthDate, to: today)
              
        let ageYears: Int = components.year!
              //let ageMonths = components.month
              //let ageDays = components.day
        print("\(ageYears) years")
        let obj: [String: Any] = [
            "email": SignUpViewController.passEmail,
            "name": name.text!,
            "gender": title!,
            "dateOfBirth": dateOfBirth.text!,
            "age": ageYears 
        ]
       // ref.child("PersonalInfo").setValue(object)
        ref.child("PersonalInfo").child(uid!).setValue(obj)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        
        
        

              //5 - display age in label
       
    //    let formattedDate = dateFormatter.string(from: dateOfBirth.text)
        
        
        
        
        
//        Auth.auth()!.createUserWithEmail(text2, password: pwd, completion: { authData, error  in
//            if error == nil {
//                let userData = ["name": name,
//                                "surname ": surname]
//                let ref = FIRDatabase.database().reference()
//                ref.child("users").child(authData!.uid).setValue(userData)
//            } else {
//                // handle error
//            }
//        })
    }

//    func createDatePicker(){
//        dateOfBirth.textAlignment = .center
//
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        toolbar.setItems([doneBtn], animated: true)
//        dateOfBirth.inputAccessoryView = toolbar
//        dateOfBirth.inputView = datePicker
//        datePicker.datePickerMode = .date
//       // let formattedDate = dateFormatter.string(from: dateOfBirth)
//        if #available(iOS 14, *) {
//            datePicker.datePickerMode = .date
//            datePicker.preferredDatePickerStyle = .wheels
//        }
//
//
//    }
//
//    @objc func donePressed(){
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .none
//        dateOfBirth.text = "\(datePicker.date)"
//
//        self.view.endEditing(true)
//
//    }
   
    
}
