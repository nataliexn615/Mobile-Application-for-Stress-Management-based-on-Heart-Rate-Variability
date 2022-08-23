//
//  SignUp2ViewController.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
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

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))



       view.addGestureRecognizer(tap)
        dateOfBirth.delegate = self
        let hehe = SignUpViewController.passEmail
        ref = Database.database().reference()
        view.addSubview(doneBtn)
        let text2 = SignUpViewController.passEmail.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
        print(text2)
        doneBtn.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)

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
    
        view.endEditing(true)
    }
    @IBAction func mydatePickerAction(_ sender: UIDatePicker) {
       
        let dateValue = DateFormatter()
        dateValue.dateFormat = "dd-MM-yyyy"
        dateOfBirth.text = dateValue.string(from: chooseDate.date)
    }
        
    @objc private func addNewEntry(){
        let uid = Auth.auth().currentUser?.uid
        let title = gender.titleForSegment(at: gender.selectedSegmentIndex)
        let birthDate = chooseDate.date
              
     
              let today = Date()
              let calendar = Calendar.current
              
             
              let components = calendar.dateComponents([.year], from: birthDate, to: today)
              
        let ageYears: Int = components.year!
            
        print("\(ageYears) years")
        let obj: [String: Any] = [
            "email": SignUpViewController.passEmail,
            "name": name.text!,
            "gender": title!,
            "dateOfBirth": dateOfBirth.text!,
            "age": ageYears 
        ]
     
        ref.child("PersonalInfo").child(uid!).setValue(obj)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
    }


}
