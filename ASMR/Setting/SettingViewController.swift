//
//  Setting ViewController.swift
//  
//
//  Created by Ying Nam lee on 30/3/2021.
//

import Foundation
import UserNotifications
import FirebaseAuth
import Firebase
//
//  ViewController.swift
//  SettingsTemplate
//
//  Created by Stephen Dowless on 2/10/19.
//  Copyright © 2019 Stephan Dowless. All rights reserved.
//

import UIKit

struct Section {
    let title: String
    let option: [SettingsOptionType]
}

enum SettingsOptionType{
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption{
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}
struct SettingsOption{
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    static var ifGranted = false
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    
    static var getAge:Int = 0
    static var getEmail:String = ""
    static var getName:String = ""
    static var getGender:String = ""
    
    @IBOutlet weak var userEmail: UITextView!
    @IBOutlet weak var UserName: UITextView!
    var ref:DatabaseReference!
    // ref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        
        view.addSubview(tableView)
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        super.viewDidLoad()
        configure()
        title = "Settings"
        Database.database().reference().child("PersonalInfo").child(uid!).observe(.value, with: { [self] snapshot in
            for child in snapshot.children{
                let valueD = child as! DataSnapshot
                if valueD.key == "name"{
                    SettingViewController.getName = valueD.value as! String
                    UserName.text = SettingViewController.getName
                }
                if valueD.key == "email"{
                    SettingViewController.getEmail = valueD.value as! String
                    userEmail.text = SettingViewController.getEmail
                }
                
            }
            
        }
        )
        checkPermitted()

    }
    func configure(){
        models.append(Section(title: "General", option: [

            .staticCell(model: SettingsOption(title: "Job", icon: UIImage(systemName: "bluetooth"), iconBackgroundColor: .link){
                
            })
        ]))
        models.append(Section(title: "Account", option: [

        .switchCell(model: SettingsSwitchOption(title: "Notifications", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink, handler: {
                 
        }, isOn: false)),
            .staticCell(model: SettingsOption(title: "Logout", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink){
                
            })]
        
        )
    )
    }
    func checkPermitted(){
        let current = UNUserNotificationCenter.current()
                current.getNotificationSettings(completionHandler: { permission in
                    switch permission.authorizationStatus  {
                    case .authorized:
                        print("User granted permission for notification")
                        SettingViewController.ifGranted = true
                    case .denied:
                        print("User denied notification permission")
                        SettingViewController.ifGranted = false
                    case .notDetermined:
                        print("Notification permission haven't been asked yet")
                    case .provisional:
                        // @available(iOS 12.0, *)
                        print("The application is authorized to post non-interruptive user notifications.")
                    case .ephemeral:
                        // @available(iOS 14.0, *)
                        print("The application is temporarily authorized to post notifications. Only available to app clips.")
                    @unknown default:
                        print("Unknow Status")
                    }
                })
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    // MARK: - Helper Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].option.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].option[indexPath.row]
        switch model.self {
            case .staticCell(let model):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SettingTableViewCell.identifier,
                    for: indexPath
                ) as? SettingTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.configure(with: model)
                return cell
            case .switchCell(let model):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SwitchTableViewCell.identifier,
                    for: indexPath
                ) as? SwitchTableViewCell else {
                    
                    return UITableViewCell()
                }
          
                cell.configure(with: model)
                return cell
        }

    }
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {

        switch sender.tag {
        case 0:
            
            print(sender.tag)
            
        default:
            break
        }

        print(sender.selectedSegmentIndex)
    }
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
    
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].option[indexPath.row]

        switch type.self {
            case .staticCell(let model):
                model.handler()
            case .switchCell(let model):
                model.handler()
        }
        if models[0].title == "General" {
        if indexPath.row == 0 {
            let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "changeJob")
            vc.modalPresentationStyle = .popover
            self.present(vc, animated: true, completion: nil)
            
        }
        }
        if models[1].title == "Account" {
            if indexPath.row == 1 {
                
//            do {
//                try Auth.auth().signOut()
//                navigationController?.popToRootViewController(animated: true)
//            }
//               catch { print("already logged out") }
       // navigationController?.popToRootViewController(animated: true)
                let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "logout")
                vc.modalPresentationStyle = .popover
                self.present(vc, animated: true, completion: nil)
            }
        }
        }
        
        
    
}
