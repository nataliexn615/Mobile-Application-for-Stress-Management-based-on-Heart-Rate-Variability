//
//  PulseViewController.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import FirebaseAuth
import FirebaseDatabase
class PulseViewController: UIViewController {
    var xv = [Double](repeating: 0.0, count: 10 + 1)
    var yv = [Double](repeating: 0.0, count: 10 + 1)


    @IBOutlet weak var showlabel: UILabel!
    @IBOutlet weak var showStart: UIButton!
    @IBOutlet weak var showAskLabel: UILabel!
    @IBOutlet weak var HRVStatus: UITextView!

    var newStruct = CalendarViewController.hrvData.self
    @IBOutlet weak var showHRV: UILabel!
    @IBOutlet weak var pulseLabel: UILabel!
    @IBOutlet weak var thresholdLabel: UILabel!
    @IBOutlet weak var previewLayerShadowView: UIView!
    @IBOutlet weak var previewLayer: UIView!
    private var validFrameCounter = 0
    private var heartRateManager: HeartRateManager!

    private var pulseDetector = PulseDetector()
    private var inputs: [CGFloat] = []
    private var measurementStartedFlag = false
    private var timer = Timer()
    private var newTimerr = Timer()
    private var countTimer = Timer()

    @IBOutlet weak var counter: UILabel!
    init() {
        super.init(nibName: "PulseViewController", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    var counting = 30
    override func viewDidLoad() {
       

        counter.textAlignment = .center
        showHRV.textAlignment = .center
        counter.text = "30"
        
        previewLayer.layer.cornerRadius = 12.0
        super.viewDidLoad()
        showAskLabel.textAlignment = .center
        showAskLabel.text = "Press 👆🏻Start👆🏻 when you are ready"
       
        counter.text = String(30)
        thresholdLabel.text = "Cover the back camera until the image turns red 🟥"
        
    }
 
    @IBAction func buttonPressed(_ sender: Any) {
       
        showStart.isHidden = true
        let specs = VideoSpec(fps: 30, size: CGSize(width: 300, height: 300))
        heartRateManager = HeartRateManager(cameraType: .back, preferredSpec: specs, previewContainer: previewLayer.layer)
        
        heartRateManager.imageBufferHandler = { [unowned self] (imageBuffer) in
            self.handle(buffer: imageBuffer)}
        heartRateManager.startCapture()
        showAskLabel.text = "seconds till your measurement ends."
        Timer.scheduledTimer(timeInterval: 31, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: false)
   
        
        countTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateNewwCounter), userInfo: nil, repeats: true)

    }
    @objc func updateNewwCounter() {
        if counting == 30 {
                  
               }
               if counting > 0 {
                counter.text = String(counting)
                   counting -= 1
               } else if counting == 0{
             
                counter.text = String(counting)
                toggleTorch(status: false)
                self.pulseLabel.alpha = 0
                self.pulseLabel.isHidden = true
             
               }
    }
    @objc func updateCounter() {
     
            calculatedNewarray.removeAll()
            calculatedarray.removeAll()
        heartRateManager.stopCapture()
    
           
          
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
            dateFormator.dateFormat = "dd-MM-yyyy"
            
         let timeFormator = DateFormatter()
         timeFormator.dateFormat = "HH:mm"
            let StartDate = dateFormator.string(from: startDate!)
            let timeRecord = timeFormator.string(from: startDate!)
            let uid = Auth.auth().currentUser?.uid
            let obj: [String: Any] = [
               "date": StartDate,
                "HRVData": RMSSD
            ]
            
        ref.child("HRVData").child(uid!).child(String(StartDate)).child(timeRecord).child("HRVData").setValue(RMSSD)

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

        }
        
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupPreviewView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculatedNewarray.removeAll()
        calculatedarray.removeAll()
        HRVStatus.text = ""
        showHRV.text = " "
        counting = 30
        showStart.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.countTimer != nil {
            self.countTimer.invalidate()
             }
        previewLayer.layer.masksToBounds = false
    }
    
   
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
                        if(self.counter.text == "0"){
                            self.pulseLabel.isHidden = true
                        } else{
                        self.pulseLabel.isHidden = false
                        self.pulseLabel.text = "\(lroundf(pulse)) BPM"
                        }
                    }
                }
            })
        }
    }
}


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
            let filtered = processValue(value: Double(hsv.0))
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
    typealias RGB = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    typealias HSV = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)

    func rgb2hsv(_ rgb: RGB) -> HSV {
        var hsb: HSV = (hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 0.0)
        
        let rgbRed: CGFloat = rgb.red
        let rgbGreen: CGFloat = rgb.green
        let rgbBlue: CGFloat = rgb.blue
        
        let maxV: CGFloat = max(rgbRed, max(rgbGreen, rgbBlue))
        let minV: CGFloat = min(rgbRed, min(rgbGreen, rgbBlue))
        var h: CGFloat = 0
        var s: CGFloat = 0
        let b: CGFloat = maxV
        
        let d: CGFloat = maxV - minV
        
        s = maxV == 0 ? 0 : d / minV;
        
        if (maxV == minV) {
            h = 0
        } else {
            if (maxV == rgbRed) {
                h = (rgbGreen - rgbBlue) / d + (rgbGreen < rgbBlue ? 6 : 0)
            } else if (maxV == rgbGreen) {
                h = (rgbBlue - rgbRed) / d + 2
            } else if (maxV == rgbBlue) {
                h = (rgbRed - rgbGreen) / d + 4
            }
            
            h /= 6;
        }
        
        hsb.hue = h
        hsb.saturation = s
        hsb.brightness = b
        hsb.alpha = rgb.alpha
        return hsb
    }
    func processValue(value: Double) -> Double {
        xv[0] = xv[1]
        xv[1] = xv[2]
        xv[2] = xv[3]
        xv[3] = xv[4]
        xv[4] = xv[5]
        xv[5] = xv[6]
        xv[6] = xv[7]
        xv[7] = xv[8]
        xv[8] = xv[9]
        xv[9] = xv[10]
        xv[10] = value/1.894427025e+01
        
        yv[0] = yv[1]
        yv[1] = yv[2]
        yv[2] = yv[3]
        yv[3] = yv[4]
        yv[4] = yv[5]
        yv[5] = yv[6]
        yv[6] = yv[7]
        yv[7] = yv[8]
        yv[8] = yv[9]
        yv[9] = yv[10]

        yv[10] = (xv[10] - xv[0]) + 5 * (xv[2] - xv[8]) + 10 * (xv[6] - xv[4]) + (-0.0000000000 * yv[0]) + (0.0357796363 * yv[1]) + (-0.1476158522 * yv[2]) + (0.3992561394 * yv[3]) + (-1.1743136181 * yv[4]) + (2.4692165842 * yv[5]) + (-3.3820859632 * yv[6]) + (3.9628972812 * yv[7]) + (-4.3832594900 * yv[8]) + (3.2101976096 * yv[9])

        return yv[10]
    }
}
