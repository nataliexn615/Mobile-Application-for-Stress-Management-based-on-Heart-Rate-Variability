//
//  QuestionData.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single
}

struct Answer {
    var text: String
    var type: ASMRtype
}

enum ASMRtype: String {
       case whispering = "Whispering", tapping = "Tapping", physicalTouch = "Physical touch", physicalAttention = "Physical Attention", pageTurning = "Page Turning", light = "Light", roleplay = "Roleplay", eating = "Eating", concentration = "Concentration",massage = "Massage",crinkling = "Crinkling"
    
    var definition: String {
        switch self {
        case .whispering:
            return "Try out our 🗣️Whispering playlist. It will surely suits you."
        case .tapping:
            return "Try out our ☝🏻Tapping playlist. It will surely suits you."
        case .physicalTouch:
            return "Try out our ✋🏻Physical Touch playlist. It will surely suits you."
        case .physicalAttention:
            return "Try out our 👀Physical Attention playlist. It will surely suits you."
        case .pageTurning:
            return "Try out our 📖Page Turning playlist. It will surely suits you."
        case .light:
            return "Try out our 🔆Light playlist. It will surely suits you."
        case .roleplay:
            return "Try out our 🥼Roleplay playlist. It will surely suits you."
        case .eating:
            return "Try out our 🍕Eating playlist. It will surely suits you."
        case .concentration:
            return "Try out our 📚Concentration playlist. It will surely suits you."
        case .massage:
            return "Try out our 💆🏻Massage playlist. It will surely suits you."
        case .crinkling:
            return "Try out our 🗞️Crinkling playlist. It will surely suits you."
         
        }
    }
    
}
