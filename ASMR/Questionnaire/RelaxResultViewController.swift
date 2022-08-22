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

class RelaxResultViewController: UIViewController {

  
    @IBOutlet weak var detailExplan: UITextView!
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    var responses: [Answer]!
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
    }
    
   func calculatePersonalityResult() {
          var frequencyOfAnswers: [ASMRtype: Int] = [:]
          let responseTypes = responses.map{ $0.type }
          
          for response in responseTypes {
              frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
          }
          
          let frequentAnswersSorted = frequencyOfAnswers.sorted(by:
          {(pair1, pair2) -> Bool in
              return pair1.value > pair2.value
          })
          
          let mostCommonAnswer = frequentAnswersSorted.first!.key
          
          resultAnswerLabel.text = "\(mostCommonAnswer.rawValue)"
          resultAnswerLabel.textAlignment = .center;
          resultDefinitionLabel.text = mostCommonAnswer.definition
    switch resultAnswerLabel.text{
        case "Whispering" :
            detailExplan.text = "ASMR creators speak softly rather than whisper, but regardless, a soft voice is tingle-inducing for almost anyone. Sometimes, certain words or sounds are emphasized or repeated due to their particularly relaxing effect. These can be especially effective for bed time relaxation. While you can certainly play such sounds through speakers, you may want to consider something like this headband with bluetooth speakers built in."
        case "Tapping" :
            detailExplan.text = "This trigger can include tapping surfaces with long fingernails or with the tips of the fingers for a softer sound. Many get creative with the surfaces that they tap to vary the different sounds that can be made by tapping."
        case "Physical touch" :
            detailExplan.text = "If you have ever felt relaxed while getting a haircut or a simple doctor’s examination, you may have experienced this ASMR trigger. The most common use of physical touch in ASMR videos includes simulating hair playing or face touching. Try a basic scalp massager, or something more advanced for an at-home experience."
        case "Physical Attention" :
            detailExplan.text = "While personal attention intersects with physical touch, it falls into a broader category. Sometimes, just having someone look at and speak to you with unbroken attention can trigger ASMR tingles."
        case "Page Turning" :
            detailExplan.text = "Reading is a relaxing activity for many, and to watch and listen to someone else do it can bring about feelings of ASMR. Not all ASMR focuses on sound. Some ASMR videos feature someone moving his or her hands in front of the camera, and the visuals of this alone can trigger ASMR for many people"
        case "Light" :
            detailExplan.text = "This trigger involves someone waving a gentle flashlight in front of the camera. You can recreate this experience at home with a simple bed side light projector, which is especially useful for winding down at night."
        case "Roleplay" :
            detailExplan.text = "Many ASMR videos feature the creator roleplaying certain scenarios, such as a doctor’s visit, a haircut, or even a zombie apocalypse. This can make for a more personal and engaging experience for viewers that creates an intensified tingling sensation."
        case "Eating" :
            detailExplan.text = "While many people are disgusted by watching people eat, others experience ASMR from it. Sounds associated with eating that can be triggers include chewing or slurping. Cooking sounds can also be pleasing for more people and falls in a similar category as eating."
        case "Concentration" :
            detailExplan.text = "Watching someone concentrate on a task can be relaxing for many ASMR viewers. If painting is your thing, consider trying your hand with a table-top painting kit. You may just discover other pleasing ASMR sounds in the process."
        case "Massage" :
            detailExplan.text = "Massages are the ultimate relaxing activity. Even if you can’t afford one on yourself, it can be relaxing to watch someone else give or receive a massage, a trigger that combines personal attention, physical touch, and soft speaking. A great way to do this at home is through a gentle massage on the face, where there's a high density of nerve endings. A high quality moisturizer and/or a facial roller can further elevate the sensation."
        case "Crinkling" :
            detailExplan.text = "This trigger involves crinkling or squishing a variety of materials, including plastic wrappers, aluminum foil, or bubble wrap. More popular these days are kinetic sands and those water absorbing beads. While some of these items are generally marketed towards children, people of all ages can enjoy them just the same!"
        default:
            print ("")
    }
    
        
 
      }
    
    @IBAction func gotoASMR(_ sender: Any) {
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "ASMRmenu")
        vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
    }
    @IBAction func donePressed(_ sender: Any) {
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "mainHome")
        vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
    }
    }


