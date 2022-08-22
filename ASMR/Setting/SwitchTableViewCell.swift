//
//  Setting ViewController.swift
//
//
//  Created by Ying Nam lee on 30/3/2021.
//

import Foundation

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


class SwitchTableViewCell: UITableViewCell {
    
  static let identifier = "SwitchTableViewCell"
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .systemBlue

        return mySwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        contentView.addSubview(mySwitch)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        let imageSize: CGFloat = size/1.5
        iconImageView.frame = CGRect(x: (size-imageSize)/2, y: (size-imageSize)/2, width:imageSize, height: imageSize)
        mySwitch.sizeToFit()
        mySwitch.frame = CGRect(
            x: contentView.frame.size.width - mySwitch.frame.size.width - 20,
            y: (contentView.frame.size.height - mySwitch.frame.size.height)/2,
            width: mySwitch.frame.size.width,
            height: mySwitch.frame.size.height
        )
        if SettingViewController.ifGranted {
            mySwitch.isOn = true
        } else {
            mySwitch.isOn = false
        }
        label.frame = CGRect(
            x: 25 + iconContainer.frame.size.width,
            y: 0,
            width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
            height: contentView.frame.size.height
        )
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil

        
    }
    public func configure(with model: SettingsSwitchOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        mySwitch.isOn = model.isOn
        mySwitch.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .touchUpInside)

    }
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        if mySwitch.isOn {
            let center = UNUserNotificationCenter.current()
            print(center)
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            }

            // Step 2: Create the notification content
            let content = UNMutableNotificationContent()
            content.title = "Time to relax"
            content.body = "Continue your ASMR Playlist"

            // Step 3: Create the notification trigger
            // let date = Date().addingTimeInterval(10)

            // var dateComponents = DateComponents()
            //  dateComponents.calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.hour =  HomeViewController.getStartTimeNew/100
            dateComponents.minute =  HomeViewController.getStartTimeNew%100
            print(HomeViewController.getStartTimeNew)
      //      dateComponents.hour = getStartTimeNew/100
    //        dateComponents.minute = getStartTimeNew%100
            print(dateComponents)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // Step 4: Create the request

            let uuidString = UUID().uuidString

            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

            // Step 5: Register the request
            center.add(request) { (error) in
                if error != nil{
                    print("error")
                }
            }
      
        }
        if mySwitch.isOn == false {
            print("Bye")
      
        }
    }
    
    
}
