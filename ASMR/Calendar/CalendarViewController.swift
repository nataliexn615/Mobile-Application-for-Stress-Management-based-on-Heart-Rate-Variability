import UIKit
import HealthKit
//import CalendarHeatmap
import FSCalendar
import Foundation
import FirebaseAuth
import Firebase

class CalendarViewController:
    UIViewController,UITableViewDelegate, UITableViewDataSource, FSCalendarDelegate{
    var getTime:String = ""
    let healthStore = HKHealthStore()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var calendarView: FSCalendar!
    @IBOutlet var showDatee: UITextView!
    var HRVRank = false
    var ref:DatabaseReference!
    let uid = Auth.auth().currentUser?.uid
    @IBOutlet weak var detailTextLabel: UILabel!
    override func viewDidLoad() {
       
       // getHRVdatabase()
        Database.database().reference().child("PersonalInfo").child(uid!).observe(.value, with: { [self] snapshot in
            for child in snapshot.children{
                let valueD = child as! DataSnapshot
                if valueD.key == "age"{
                    HomeViewController.getAge = valueD.value as! Int
                    print(HomeViewController.getAge)
                }
                if valueD.key == "gender"{
                    HomeViewController.getGender = valueD.value as! String
                    print(HomeViewController.getGender)
                }
            }
        }
        )
        super.viewDidLoad()
        let today = Date()
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "dd/MM/yyyy"
        CalendarViewController.hehehaha = formatter3.string(from: today)
        //print(formatter3.string(from: today))
        calendarView.delegate = self
       
        getHRVdatabase()
        tableView.delegate = self
        tableView.dataSource = self
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }
    func authorizeHealthKit(){
        let read = Set([HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!])
        let share = Set([HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!])
        healthStore.requestAuthorization(toShare: share, read: read) { (chk, error) in
            if(chk){
                print("permission granted")
                self.latestHeartRate()               }
        }
    }
    struct hrvData {
        var date : String
        var time : String
        var HRV : String
    }
    static var hrvArray = [hrvData]()
    static var hrvtableArray = [hrvData]()
    func latestHeartRate() {
        
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else{
            return
        }
        
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit:
                                    Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { [self] (sample, result, error) in
            guard error == nil else{
                return
            }
            print(result?.count)
            CalendarViewController.hrvArray.removeAll()
            for data in result as? [HKQuantitySample] ?? [] {
                let unit = HKUnit(from: "ms")
                let latestHRV = data.quantity.doubleValue(for: unit)
                let dateFormator = DateFormatter()
                dateFormator.dateFormat = "dd/MM/yyyy"
                let timeFormator = DateFormatter()
                timeFormator.dateFormat = "hh:mm"
                let StartDate = dateFormator.string(from: data.startDate)
                let timeRecord = timeFormator.string(from: data.startDate)
                print(StartDate,timeRecord,latestHRV)
                
                CalendarViewController.hrvArray.append(hrvData(date: String(StartDate), time:String(timeRecord), HRV:String(latestHRV)))
            }
        }
        healthStore.execute(query)
    }
    
    static var hehehaha = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CalendarViewController.hrvtableArray.removeAll()
        for i in 0..<CalendarViewController.hrvArray.count{
            if CalendarViewController.hrvArray[i].date == CalendarViewController.hehehaha{
                CalendarViewController.hrvtableArray.append(CalendarViewController.hrvArray[i])
            }
        }
        for i in 0..<CalendarViewController.hrvtableArray.count{
            print(CalendarViewController.hrvtableArray[i])
        }
        print(CalendarViewController.hrvtableArray.count)
        return CalendarViewController.hrvtableArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "productstable")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "productstable")
        }
        cell?.textLabel?.text =
            CalendarViewController.hrvtableArray[indexPath.row].HRV
        cell?.detailTextLabel?.text = CalendarViewController.hrvtableArray[indexPath.row].time
        let getHRV = Double(CalendarViewController.hrvtableArray[indexPath.row].HRV) ?? 0
        if HomeViewController.getGender == "Male" {
            switch HomeViewController.getAge {
                case HomeViewController.getAge where (HomeViewController.getAge < 35):
                    if getHRV >= 19.8 && getHRV <= 59.6{
                        cell?.imageView?.image = UIImage(named: "smileImg.png")
                    }else {
                        cell?.imageView?.image = UIImage(named: "sadImg.png")
                    }
                case HomeViewController.getAge where (HomeViewController.getAge < 45):
                    if getHRV >= 15.5 && getHRV <= 48.5{
                        cell?.imageView?.image = UIImage(named: "smileImg.png")
                    }else {
                        cell?.imageView?.image = UIImage(named: "sadImg.png")
                    }
                case HomeViewController.getAge where (HomeViewController.getAge < 55):
                    if getHRV >= 12.1 && getHRV <= 33.9{
                        cell?.imageView?.image = UIImage(named: "smileImg.png")
                    }else {
                        cell?.imageView?.image = UIImage(named: "sadImg.png")
                    }
                case HomeViewController.getAge where (HomeViewController.getAge < 65):
                    if getHRV >= 8.8 && getHRV <= 31{
                        cell?.imageView?.image = UIImage(named: "smileImg.png")
                    }else {
                        cell?.imageView?.image = UIImage(named: "sadImg.png")
                    }
                case HomeViewController.getAge where (HomeViewController.getAge < 75):
                    if getHRV >= 8.4 && getHRV <= 29.8{
                        cell?.imageView?.image = UIImage(named: "smileImg.png")
                    }else {
                        cell?.imageView?.image = UIImage(named: "sadImg.png")
                    }
                default:
                    cell?.imageView?.image = UIImage(named: "sadImg.png")
            }
        }
        if HomeViewController.getGender == "Female" {
            switch HomeViewController.getAge {
                case HomeViewController.getAge where (HomeViewController.getAge < 35):
                    if getHRV >= 20.1 && getHRV <= 65.7{
                        cell?.imageView?.image = UIImage(named: "smileImg.png")
                    }else {
                        cell?.imageView?.image = UIImage(named: "sadImg.png")
                    }
                case HomeViewController.getAge where (HomeViewController.getAge < 45):
                    if getHRV >= 16.9 && getHRV <= 53.9{
                        cell?.imageView?.image = UIImage(named: "smileImg.png")
                    }else {
                        cell?.imageView?.image = UIImage(named: "sadImg.png")
                    }
                case HomeViewController.getAge where (HomeViewController.getAge < 55):
                    if getHRV >= 12.7 && getHRV <= 39.9{
                        cell?.imageView?.image = UIImage(named: "smileImg.png")
                    }else {
                        cell?.imageView?.image = UIImage(named: "sadImg.png")
                    }
                case HomeViewController.getAge where (HomeViewController.getAge < 65):
                    if getHRV >= 9.5 && getHRV <= 33.3{
                        cell?.imageView?.image = UIImage(named: "smileImg.png")
                    }else {
                        cell?.imageView?.image = UIImage(named: "sadImg.png")
                    }
                case HomeViewController.getAge where (HomeViewController.getAge < 75):
                    if getHRV >= 7.3 && getHRV <= 30.9{
                        cell?.imageView?.image = UIImage(named: "smileImg.png")
                    }else {
                        cell?.imageView?.image = UIImage(named: "sadImg.png")
                    }
                    
                default:
                    cell?.imageView?.image = UIImage(named: "sadImg.png")
            }}
        return cell!
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let formattedDate = dateFormatter.string(from: date)
        CalendarViewController.hehehaha = String(formattedDate)
        tableView.reloadData()
    }
   
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return CalendarViewController.hehehaha
        
    }
    
    func getHRVdatabase(){
        authorizeHealthKit()
    //    CalendarViewController.hrvArray.removeAll()
        Database.database().reference().child("HRVData").child(uid!).observe(.value, with: { [self] snapshot in
            CalendarViewController.hrvArray.removeAll()
            for child in snapshot.children{
                let valueD = child as! DataSnapshot
                getTime = valueD.key
                Database.database().reference().child("HRVData").child(uid!).child(valueD.key).observe(.value, with: { [self] snapshot in
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
                            CalendarViewController.hrvArray.append(hrvData(date: String(StartDate), time:String(valueD.key), HRV:String(HomeViewController.mykey)))
                        }}})}})}}
            
