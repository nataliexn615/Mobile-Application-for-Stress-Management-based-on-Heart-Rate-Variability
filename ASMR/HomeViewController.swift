//
//  SignUpViewController.swift
//  ASMR
//
//  Created by Ying Nam lee on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class HomeViewController: UIViewController {

    @IBOutlet weak var willBe: UITextView!
    
    private var newtimer = Timer()
    var countnew = 0
    @IBOutlet weak var continuePlay: UIImageView!
    @IBOutlet weak var pulsestatustext: UIView!
    var normalString: String = ""
    @IBOutlet weak var showIfNoASMR: UITextView!
    var abnormalString: String = ""
    var newStruct = CalendarViewController.hrvData.self
    private var timer = Timer()
    @IBOutlet weak var showName: UITextView!
    var counts: [String: Int] = [:]
    var countMax = [String: Int]()
    var count = 0
    var mytry: String = ""
    var homeemotionArray : Array<String> = []
    static var newemotionArray : Array<String> = []
    
    @IBOutlet weak var HRVStatus: UITextView!
    var emotionResultArray: Array<String> = []
    static var asmrcategory : String = ""
    static var useremotion : String = ""
    @IBOutlet weak var rectInfo: UIButton!
    @IBOutlet weak var bestASMR: UILabel!
    static var getGender: String = ""
    static var getName: String = ""
    static var getAge:Int = 0
    @IBOutlet weak var moodStatus: UILabel!
    @IBOutlet weak var askPulse: UITextView!
    static var keyD: String = ""
    static var keyK: String = ""
    static var mykey:Double = 0.0
    static var keyE: String = ""
    static var asmrkey: String = ""
    static var emotionkey: String = ""
    static var isCompleted = false
    var stopLoop = false
    @IBOutlet weak var moodDecription: UITextView!
    var ref:DatabaseReference!
    let uid = Auth.auth().currentUser?.uid
    static var getStartTime: String = ""
    static var getLunchTime: String = ""
    static var getEndTime: String = ""
    static var getStartTimeNew:Int = 0
    static var getLunchTimeNew:Int = 0
    static var getEndTimeNew:Int = 0
    override func viewDidLoad() {
        Database.database().reference().child("JobInfo").child(uid!).observe(.value, with: { [self] snapshot in
            for child in snapshot.children{
                let valueD = child as! DataSnapshot
                if valueD.key == "startTime"{
                    HomeViewController.getStartTime = valueD.value as! String
                    HomeViewController.getStartTimeNew = Int( HomeViewController.getStartTime) ?? 0
                    print(HomeViewController.getStartTimeNew)
                    
                }
                if valueD.key == "lunchTime"{
                    HomeViewController.getLunchTime = valueD.value as! String
                    HomeViewController.getLunchTimeNew = Int( HomeViewController.getLunchTime) ?? 0
                }
                if valueD.key == "endTime"{
                    HomeViewController.getEndTime = valueD.value as! String
                    HomeViewController.getEndTimeNew = Int( HomeViewController.getEndTime) ?? 0
                    
                }
                
            }

        }
        )
//        let center = UNUserNotificationCenter.current()
//        print(center)
//        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
//        }
//
//        // Step 2: Create the notification content
//        let content = UNMutableNotificationContent()
//        content.title = "Time to relax"
//        content.body = "Continue your ASMR Playlist"
//
//        // Step 3: Create the notification trigger
//        // let date = Date().addingTimeInterval(10)
//
//        // var dateComponents = DateComponents()
//        //  dateComponents.calendar = Calendar.current
//        var dateComponents = DateComponents()
//        dateComponents.hour =  HomeViewController.getStartTimeNew/100
//        dateComponents.minute =  HomeViewController.getStartTimeNew%100
//        print(HomeViewController.getStartTimeNew)
//  //      dateComponents.hour = getStartTimeNew/100
////        dateComponents.minute = getStartTimeNew%100
//        print(dateComponents)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        // Step 4: Create the request
//
//        let uuidString = UUID().uuidString
//
//        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
//
//        // Step 5: Register the request
//        center.add(request) { (error) in
//            if error != nil{
//                print("error")
//            }
//        }
    
        
        continuePlay.isHidden = true
        showIfNoASMR.text = "You have not try out our ASMR playlist function, go to the Relax Page to explore which ASMR type suits YOU!"
        willBe.text = "will be shown here"
        HRVStatus.text = "Please go to the Pulse Page to test your Stress Level 📈"
        bestASMR.text = "None"
        bestASMR.textAlignment = .center

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        continuePlay.isUserInteractionEnabled = true
        continuePlay.addGestureRecognizer(tapGestureRecognizer)
        
        pulsestatustext.layer.cornerRadius = 15
        abnormalString = "It seems that your stress level is normal, but you can still try out our tailor-prepared 🎧ASMR playlist🎧 for an audio and visual stimuli 🤤"
        normalString = "It seems that you are a bit stressful, try to experience our tailor-prepared 🎧ASMR playlist🎧 for an audio and visual stimuli 🤤"
        
        
        mydatabaseData()
        super.viewDidLoad()
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        // askPulse.layer.cornerRadius = 25
        // askPulse.layer.borderColor = UIColor.black.cgColor
        myHRVData()
        Database.database().reference().child("PersonalInfo").child(uid!).observe(.value, with: { [self] snapshot in
            for child in snapshot.children{
                let valueD = child as! DataSnapshot
                if valueD.key == "age"{
                    HomeViewController.getAge = valueD.value as! Int
                   // print(HomeViewController.getAge)
                }
                if valueD.key == "gender"{
                    HomeViewController.getGender = valueD.value as! String
                        // print(HomeViewController.getGender)
                }
                if valueD.key == "name"{
                    HomeViewController.getName = valueD.value as! String
                   // print(HomeViewController.getName)
                    showName.text = "Welcome back, " + HomeViewController.getName
                }
            }
        }
        )
    }
    @objc func updatenewCounter() {
 
//            var videos: [Video] = Video.fetchEatingVideos()
//            switch bestASMR.text{
//                case "Whispering":
//                     videos = Video.fetchWhisperingVideos()
//                case "Tapping":
//                    videos = Video.fetchTappingVideos()
//                case  "Physical touch":
//                     videos = Video.fetchPhysicalTouchVideos()
//                case "Physical Attention":
//                     videos = Video.fetchPhysicalAttentionVideos()
//                case "Page Turning" :
//                     videos = Video.fetchpageTurningVideos()
//                case "Light":
//                     videos = Video.fetchLightVideos()
//                case "Roleplay":
//                     videos = Video.fetchRolePlayVideos()
//                case "Eating":
//                     videos = Video.fetchEatingVideos()
//                case "Concentration":
//                     videos = Video.fetchConcentrationVideos()
//                case "Massage":
//                     videos = Video.fetchMassageVideos()
//                case "Crinkling":
//                    videos = Video.fetchRinklingVideos()
//
//                default:
//                    print("default")
//
//            }
//
//
//            let selectedVideo = videos[1]
//
//            displayVideo.choseVideo = selectedVideo.videoID
//            continuePlay.image = UIImage(named: selectedVideo.thumbNail)
            
          
            // Step 1: Ask for permission
//            let center = UNUserNotificationCenter.current()
//            print(center)
//            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
//            }
//
//            // Step 2: Create the notification content
//            let content = UNMutableNotificationContent()
//            content.title = "Time to relax"
//            content.body = "Continue your ASMR Playlist"
//
//            // Step 3: Create the notification trigger
//            // let date = Date().addingTimeInterval(10)
//
//            // var dateComponents = DateComponents()
//            //  dateComponents.calendar = Calendar.current
//            var dateComponents = DateComponents()
//            sleep(5)
//            dateComponents.hour = getStartTimeNew/100
//            dateComponents.minute = getStartTimeNew%100
//            print(dateComponents)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//            // Step 4: Create the request
//
//            let uuidString = UUID().uuidString
//
//            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
//
//            // Step 5: Register the request
//            center.add(request) { (error) in
//                if error != nil{
//                    print("error")
//                }
//            }
//
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "playYoutubeVideo")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    func myHRVData(){
        
        Database.database().reference().child("HRVData").child(uid!).observe(.value, with: { [self] snapshot in
            for child in snapshot.children{
                let valueD = child as! DataSnapshot
                HomeViewController.keyK = valueD.key
                Database.database().reference().child("HRVData").child(uid!).child(HomeViewController.keyK).observe(.value, with: { [self] snapshot in
                    //    let subscriptionSnap = snapshot.childSnapshot(forPath: "uid!")
                    let dateFormator = DateFormatter()
                    dateFormator.dateFormat = "dd/MM/yyyy"
                    let startDate = Calendar.current.date(byAdding: .month, value: 0, to: Date())
                    let StartDate = dateFormator.string(from: startDate!)
                    for child in snapshot.children{
                        let getData = child as! DataSnapshot
                        
                        if getData.key == "HRVData"{
                            let x: Double =  getData.value as! Double
                            HomeViewController.mykey  = Double(round(1000*x)/1000)
                            let display:String = String(HomeViewController.mykey)
                        //    print(HomeViewController.mykey)
                            moodStatus.text = display
                            willBe.isHidden = true
//                            CalendarViewController.hrvArray.append(newStruct.init(date: String(StartDate), time:String(HomeViewController.keyK), HRV:String(HomeViewController.mykey)))
                           // print(CalendarViewController.hrvArray)
                            if HomeViewController.getGender == "Male" {
                                switch HomeViewController.getAge {
                                    case HomeViewController.getAge where (HomeViewController.getAge < 35):
                                        if HomeViewController.mykey >= 19.8 && HomeViewController.mykey <= 59.6{
                                            HRVStatus.text = normalString
                                        }else {
                                            HRVStatus.text = abnormalString
                                        }
                                    case HomeViewController.getAge where (HomeViewController.getAge < 45):
                                        if HomeViewController.mykey >= 15.5 && HomeViewController.mykey <= 48.5{
                                            HRVStatus.text = normalString
                                        }else {
                                            HRVStatus.text = abnormalString
                                        }
                                    case HomeViewController.getAge where (HomeViewController.getAge < 55):
                                        if HomeViewController.mykey >= 12.1 && HomeViewController.mykey <= 33.9{
                                            HRVStatus.text = normalString
                                        }else {
                                            HRVStatus.text = abnormalString
                                        }
                                    case HomeViewController.getAge where (HomeViewController.getAge < 65):
                                        if HomeViewController.mykey >= 8.8 && HomeViewController.mykey <= 31{
                                            HRVStatus.text = normalString
                                        }else {
                                            HRVStatus.text = abnormalString
                                        }
                                    case HomeViewController.getAge where (HomeViewController.getAge < 75):
                                        if HomeViewController.mykey >= 8.4 && HomeViewController.mykey <= 29.8{
                                            HRVStatus.text = normalString
                                        }else {
                                            HRVStatus.text = abnormalString
                                        }
                                    default:
                                        HRVStatus.text = "Abnormal"
                                }
                            }
                            if HomeViewController.getGender == "Female" {
                                switch HomeViewController.getAge {
                                    case HomeViewController.getAge where (HomeViewController.getAge < 35):
                                        if HomeViewController.mykey >= 20.1 && HomeViewController.mykey <= 65.7{
                                            HRVStatus.text = normalString
                                        }else {
                                            HRVStatus.text = abnormalString
                                        }
                                    case HomeViewController.getAge where (HomeViewController.getAge < 45):
                                        if HomeViewController.mykey >= 16.9 && HomeViewController.mykey <= 53.9{
                                            HRVStatus.text = normalString
                                        }else {
                                            HRVStatus.text = abnormalString
                                        }
                                    case HomeViewController.getAge where (HomeViewController.getAge < 55):
                                        if HomeViewController.mykey >= 12.7 && HomeViewController.mykey <= 39.9{
                                            HRVStatus.text = normalString
                                        }else {
                                            HRVStatus.text = abnormalString
                                        }
                                    case HomeViewController.getAge where (HomeViewController.getAge < 65):
                                        if HomeViewController.mykey >= 9.5 && HomeViewController.mykey <= 33.3{
                                            HRVStatus.text = normalString
                                        }else {
                                            HRVStatus.text = abnormalString
                                        }
                                    case HomeViewController.getAge where (HomeViewController.getAge < 75):
                                        if HomeViewController.mykey >= 7.3 && HomeViewController.mykey <= 30.9{
                                            HRVStatus.text = normalString
                                        }else {
                                            HRVStatus.text = abnormalString
                                        }
                                        
                                    default:
                                        HRVStatus.text = "Abnormal"
                                }}
                        }
                    }
                }
                )
            }
        }
        )

        
    }
    func mydatabaseData(){
        let queue = DispatchQueue(label: "ASMRQueue")
        
       // print("Start task1")
        
        queue.sync{
            Database.database().reference().child("EmotionData").child(uid!).observe(.value, with: { [self] snapshot in
                for child in snapshot.children{
                    let valueD = child as! DataSnapshot
                    HomeViewController.keyD = valueD.key
                    Database.database().reference().child("EmotionData").child(uid!).child(HomeViewController.keyD).observe(.value, with: { [self] snapshot in
                        //    let subscriptionSnap = snapshot.childSnapshot(forPath: "uid!")
                        for child in snapshot.children{
                            let getData = child as! DataSnapshot
                            let mykey  = getData.key
                            if mykey == "ASMRCat" {
                                HomeViewController.asmrkey = getData.value as! String
                            } else if mykey == "emotion" {
                                HomeViewController.emotionkey = getData.value as! String
                                if HomeViewController.emotionkey == "happy"{
                                    mytry = HomeViewController.asmrkey
                                //    print(mytry)
                                    HomeViewController.newemotionArray.append(mytry)
                                    // myPrint()
                                }
                            }
                        }
                    }
                    )
                }
            }
            )
            
        }
        HomeViewController.isCompleted = true
        if stopLoop == false {
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: false)}
        
    }
    
    @objc func updateCounter() {
        
        stopLoop = true
        timer.invalidate()
        
     //print(HomeViewController.newemotionArray.count)
        for item in HomeViewController.newemotionArray {
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        for (key, value) in counts {
            // print("\(key) occurs \(value) time(s)")
        }
        HomeViewController.newemotionArray.forEach { countMax[$0] = (countMax[$0] ?? 0) + 1 }
        if let (value, count) = countMax.max(by: {$0.1 < $1.1}) {
            bestASMR.textAlignment = .center
            bestASMR.text = value
           
           
            
            continuePlay.clipsToBounds = true
            if bestASMR.text == "None" {
                showIfNoASMR.isHidden = false
               // continuePlay.isHidden = true
                
            }
            continuePlay.isHidden = false
            continuePlay.layer.cornerRadius = 15
           // print("\(value) occurs \(count) times")
//            Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(updatenewCounter), userInfo: nil, repeats: false)
            var videos: [Video] = Video.fetchEatingVideos()
            switch bestASMR.text{
                case "whispering":
                     videos = Video.fetchWhisperingVideos()
                case "tapping":
                    videos = Video.fetchTappingVideos()
                case  "physical touch":
                     videos = Video.fetchPhysicalTouchVideos()
                case "physical Attention":
                     videos = Video.fetchPhysicalAttentionVideos()
                case "page Turning" :
                     videos = Video.fetchpageTurningVideos()
                case "light":
                     videos = Video.fetchLightVideos()
                case "roleplay":
                     videos = Video.fetchRolePlayVideos()
                case "eating":
                     videos = Video.fetchEatingVideos()
                case "concentration":
                     videos = Video.fetchConcentrationVideos()
                case "massage":
                     videos = Video.fetchMassageVideos()
                case "crinkling":
                    videos = Video.fetchRinklingVideos()
                    
                default:
                    print("default")
                    
            }
            
            
            let selectedVideo = videos[1]
         
            displayVideo.choseVideo = selectedVideo.videoID
            continuePlay.image = UIImage(named: selectedVideo.thumbNail)
        }
    }
    
    
}
