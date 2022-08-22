//
//  PulseViewController.swift
//  Pulse
//
//  Created by Athanasios Papazoglou on 18/7/20.
//  Copyright © 2020 Athanasios Papazoglou. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import FirebaseAuth
import FirebaseDatabase
class PulseViewController: UIViewController {


    @IBOutlet weak var showlabel: UILabel!
    @IBOutlet weak var showStart: UIButton!
    @IBOutlet weak var showAskLabel: UILabel!
    @IBOutlet weak var HRVStatus: UITextView!
    //  var structNew = CalendarViewController.hrvData(date:  sxc, time: <#String#>, HRV: <#String#>)
    var newStruct = CalendarViewController.hrvData.self
    @IBOutlet weak var showHRV: UILabel!
    @IBOutlet weak var pulseLabel: UILabel!
    @IBOutlet weak var thresholdLabel: UILabel!
    @IBOutlet weak var previewLayerShadowView: UIView!
    @IBOutlet weak var previewLayer: UIView!
    private var validFrameCounter = 0
    private var heartRateManager: HeartRateManager!
    private var hueFilter = Filter()
    private var pulseDetector = PulseDetector()
    private var inputs: [CGFloat] = []
    private var measurementStartedFlag = false
    private var timer = Timer()
    private var newTimerr = Timer()



    @IBOutlet weak var counter: UILabel!
  
    
   
    init() {
        super.init(nibName: "PulseViewController", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    var counting = 30
    override func viewDidLoad() {
        counter.textAlignment = .center
        showHRV.textAlignment = .center
        counter.text = "30"
        
        previewLayer.layer.cornerRadius = 12.0
        super.viewDidLoad()
        showAskLabel.textAlignment = .center
        showAskLabel.text = "Press 👆🏻Start👆🏻 when you are ready"
        //initVideoCapture()
        counter.text = String(30)
        thresholdLabel.text = "Cover the back camera until the image turns red 🟥"
        
    }
 
    @IBAction func buttonPressed(_ sender: Any) {
        showStart.isHidden = true
        let specs = VideoSpec(fps: 30, size: CGSize(width: 300, height: 300))
        heartRateManager = HeartRateManager(cameraType: .back, preferredSpec: specs, previewContainer: previewLayer.layer)
        heartRateManager.imageBufferHandler = { [unowned self] (imageBuffer) in
            self.handle(buffer: imageBuffer)}
      //  sleep(1)
        
        heartRateManager.startCapture()
        showAskLabel.text = "seconds till your measurement ends."
      //  showlabel.isHidden = true
      //  showAskLabel.isHidden = true
        Timer.scheduledTimer(timeInterval: 31, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: false)
    //    sleep(3)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateNewwCounter), userInfo: nil, repeats: true)

    }
    @objc func updateNewwCounter() {
        if counting == 30 {
                  // sleep(1)
               }
               if counting > 0 {
                counter.text = String(counting)
                   counting -= 1
               } else if counting == 0{
                //counter.text == "0"{
                counter.text = String(counting)
                toggleTorch(status: false)
                
               }
    }
    @objc func updateCounter() {
       // sleep(1)
            calculatedNewarray.removeAll()
            calculatedarray.removeAll()
            heartRateManager.stopCapture()
      //      toggleTorch(status: false)
           
          
          var j = 0
          
            for i in 0...recordedArray.count {
                if i < recordedArray.count-1 {
                    let temp = recordedArray[i+1] - recordedArray[i]
                    print(temp)
                    print(i)
                    calculatedarray.append(temp)
                    print("difference",calculatedarray[j])
                    j += 1
                }
            }
            for i in 0...calculatedarray.count {
                if i < calculatedarray.count-1 {
                    let temp = calculatedarray[i+1] - calculatedarray[i]
                    print(temp)
                    print(i)
                    calculatedNewarray.append(temp)
                    j += 1
                }
            }
            for i in 0...calculatedNewarray.count {
                if i < calculatedNewarray.count-1 {
                    calculatedNewarray[i] = (calculatedNewarray[i])*(calculatedNewarray[i])
                    print(calculatedNewarray[i])
                }
            }
            var ref:DatabaseReference!
            ref = Database.database().reference()
            let sum:Double = Double(calculatedNewarray.reduce(0, +))
            let dd:Double = Double(calculatedNewarray.count)
            print(sum)
            var RMSSD: Double
            RMSSD = (sum/dd).squareRoot()
            print("RMSSD", RMSSD)
            showHRV.text = String( Double(round(1000*RMSSD)/1000))
            let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss"
            let startDate = Calendar.current.date(byAdding: .month, value: 0, to: Date())
            let dateFormator = DateFormatter()
            dateFormator.dateFormat = "dd/MM/yyyy"
            
         let timeFormator = DateFormatter()
         timeFormator.dateFormat = "HH:mm"
            let StartDate = dateFormator.string(from: startDate!)
            let timeRecord = timeFormator.string(from: startDate!)
            let uid = Auth.auth().currentUser?.uid
            let obj: [String: Any] = [
               "date": StartDate,
                "HRVData": RMSSD
            ]
            
            ref.child("HRVData").child(uid!).child(timeRecord).updateChildValues(obj)
       
//            CalendarViewController.hrvArray.append(newStruct.init(date: String(StartDate), time:String(timeRecord), HRV:String(RMSSD)))


            
            if HomeViewController.getGender == "Male" {
                switch HomeViewController.getAge {
                    case HomeViewController.getAge where (HomeViewController.getAge < 35):
                        if RMSSD >= 19.8 && RMSSD <= 59.6{
                            HRVStatus.text = "Your stress level is Normal"
                        } else {
                            HRVStatus.text = "It seems that you are a bit stressful"
                        }
                    case HomeViewController.getAge where (HomeViewController.getAge < 45):
                        if RMSSD >= 15.5 && RMSSD <= 48.5{
                            HRVStatus.text = "Your stress level is Normal"
                        }else {
                            HRVStatus.text = "It seems that you are a bit stressful"
                        }
                    case HomeViewController.getAge where (HomeViewController.getAge < 55):
                        if RMSSD >= 12.1 && RMSSD <= 33.9{
                            HRVStatus.text = "Your stress level is Normal"
                        }else {
                            HRVStatus.text = "It seems that you are a bit stressful"
                        }
                    case HomeViewController.getAge where (HomeViewController.getAge < 65):
                        if RMSSD >= 8.8 && RMSSD <= 31{
                            HRVStatus.text = "Your stress level is Normal"
                        }else {
                            HRVStatus.text = "It seems that you are a bit stressful"
                        }
                    case HomeViewController.getAge where (HomeViewController.getAge < 75):
                        if RMSSD >= 8.4 && RMSSD <= 29.8{
                            HRVStatus.text = "our stress level is Normal"
                        }else {
                            HRVStatus.text = "It seems that you are a bit stressful"
                        }
                    default:
                        HRVStatus.text = "Abnormal"
                }
        }
            if HomeViewController.getGender == "Female" {
                switch HomeViewController.getAge {
                    case HomeViewController.getAge where (HomeViewController.getAge < 35):
                        if RMSSD >= 20.1 && RMSSD <= 65.7{
                            HRVStatus.text = "Your stress level is Normal"
                        }else {
                            HRVStatus.text = "It seems that you are a bit stressful"
                        }
                    case HomeViewController.getAge where (HomeViewController.getAge < 45):
                        if RMSSD >= 16.9 && RMSSD <= 53.9{
                            HRVStatus.text = "Your stress level is Normal"
                        }else {
                            HRVStatus.text = "It seems that you are a bit stressful"
                        }
                    case HomeViewController.getAge where (HomeViewController.getAge < 55):
                        if RMSSD >= 12.7 && RMSSD <= 39.9{
                            HRVStatus.text = "Your stress level is Normal"
                        }else {
                            HRVStatus.text = "It seems that you are a bit stressful"
                        }
                    case HomeViewController.getAge where (HomeViewController.getAge < 65):
                        if RMSSD >= 9.5 && RMSSD <= 33.3{
                            HRVStatus.text = "Your stress level is Normal"
                        }else {
                            HRVStatus.text = "It seems that you are a bit stressful"
                        }
                    case HomeViewController.getAge where (HomeViewController.getAge < 75):
                        if RMSSD >= 7.3 && RMSSD <= 30.9{
                            HRVStatus.text = "Your stress level is Normal"
                        } else {
                            HRVStatus.text = "It seems that you are a bit stressful"
                        }
                        
                    default:
                        HRVStatus.text = "Abnormal"
                
        }
//                showHRV.text = String( Double(round(1000*RMSSD)/1000))
        }
        
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupPreviewView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // deinitCaptureSession()
    }
    
    // MARK: - Setup Views
    private func setupPreviewView() {
      
        previewLayer.layer.masksToBounds = true
        
        previewLayerShadowView.backgroundColor = .clear
        previewLayerShadowView.layer.shadowColor = UIColor.black.cgColor
        previewLayerShadowView.layer.shadowOpacity = 0.25
        previewLayerShadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        previewLayerShadowView.layer.shadowRadius = 3
        previewLayerShadowView.clipsToBounds = false
    }

    
    @IBOutlet weak var Status: UIButton!
    var calculatedarray: Array<Int> = []
    var calculatedNewarray: Array<Int> = []


    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        print(string + formatter.string(from: date))
    }
    
    private func toggleTorch(status: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        device.toggleTorch(on: status)
    }
    
    // MARK: - Measurement
    private func startMeasurement() {
        DispatchQueue.main.async {
            self.toggleTorch(status: true)
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] (timer) in
                guard let self = self else { return }
                let average = self.pulseDetector.getAverage()
                let pulse = 60.0/average
                if pulse == -60 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.pulseLabel.alpha = 0
                    }) { (finished) in
                        self.pulseLabel.isHidden = finished
                    }
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.pulseLabel.alpha = 1.0
                    }) { (_) in
                        self.pulseLabel.isHidden = false
                        self.pulseLabel.text = "\(lroundf(pulse)) BPM"
                    }
                }
            })
        }
    }
}

//MARK: - Handle Image Buffer
extension PulseViewController {
    fileprivate func handle(buffer: CMSampleBuffer) {
        var redmean:CGFloat = 0.0;
        var greenmean:CGFloat = 0.0;
        var bluemean:CGFloat = 0.0;
        
        let pixelBuffer = CMSampleBufferGetImageBuffer(buffer)
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer!)

        let extent = cameraImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let averageFilter = CIFilter(name: "CIAreaAverage",
                              parameters: [kCIInputImageKey: cameraImage, kCIInputExtentKey: inputExtent])!
        let outputImage = averageFilter.outputImage!

        let ctx = CIContext(options:nil)
        let cgImage = ctx.createCGImage(outputImage, from:outputImage.extent)!
        
        let rawData:NSData = cgImage.dataProvider!.data!
        let pixels = rawData.bytes.assumingMemoryBound(to: UInt8.self)
        let bytes = UnsafeBufferPointer<UInt8>(start:pixels, count:rawData.length)
        var BGRA_index = 0
        for pixel in UnsafeBufferPointer(start: bytes.baseAddress, count: bytes.count) {
            switch BGRA_index {
            case 0:
                bluemean = CGFloat (pixel)
            case 1:
                greenmean = CGFloat (pixel)
            case 2:
                redmean = CGFloat (pixel)
            case 3:
                break
            default:
                break
            }
            BGRA_index += 1
        }
        
        let hsv = rgb2hsv((red: redmean, green: greenmean, blue: bluemean, alpha: 1.0))
        // Do a sanity check to see if a finger is placed over the camera
        if (hsv.1 > 0.5 && hsv.2 > 0.5) {
            DispatchQueue.main.async {
                self.thresholdLabel.text = "Hold your index finger ☝️ still."
                self.toggleTorch(status: true)
                if !self.measurementStartedFlag {
                    self.startMeasurement()
                    self.measurementStartedFlag = true
                }
            }
            validFrameCounter += 1
            inputs.append(hsv.0)
            // Filter the hue value - the filter is a simple BAND PASS FILTER that removes any DC component and any high frequency noise
            let filtered = hueFilter.processValue(value: Double(hsv.0))
            if validFrameCounter > 60 {
                self.pulseDetector.addNewValue(newVal: filtered, atTime: CACurrentMediaTime())
            }
        } else {
            validFrameCounter = 0
            measurementStartedFlag = false
            pulseDetector.reset()
            DispatchQueue.main.async {
                self.thresholdLabel.text = "Cover the back camera until the image turns red 🟥"
            }
        }
    }
}
