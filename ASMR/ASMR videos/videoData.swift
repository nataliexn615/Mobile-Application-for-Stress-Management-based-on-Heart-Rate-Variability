//
//  videoData.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import Foundation

struct Video{
let authorName: String
let thumbNail: String
let videoID: String

static func fetchEatingVideos() -> [Video] {
    let v1 = Video(authorName: "Eating Chicken", thumbNail: "e1", videoID: "4a_NGIdhqKw")
    let v2 = Video(authorName: "Eating Jelly", thumbNail: "e2",  videoID: "iXPoIlR1UgI")
    let v3 = Video(authorName: "Eating Jelly", thumbNail: "e3", videoID: "Lbo6d4aRkJM")
     let v4 = Video(authorName: "Eating Stick", thumbNail: "e4", videoID: "DIPSjSx8-CM")
     let v5 = Video(authorName: "Eating Chicken", thumbNail: "e5",  videoID: "vSH2Ib_V6hk")
     let v6 = Video(authorName: "Eating Cake", thumbNail: "e5", videoID: "bsM1qdGAVbU")
   
 return [v1,v2,v3,v4,v5,v6]
}

static func fetchWhisperingVideos() -> [Video] {

    let v1 = Video(authorName: "Sensitive Whisper", thumbNail: "w1",videoID: "VZL1qWTsoeM")
    let v2 = Video(authorName: "Tingly Whisper", thumbNail: "w2",videoID: "Cd92G-50ZNI")
    let v3 = Video(authorName: "Close Whispering", thumbNail: "w3", videoID: "KohUW8gaNLQ")
    let v4 = Video(authorName: "CloseUp Whispering", thumbNail: "w4",videoID: "_wwWFoBVUXI")
    let v5 = Video(authorName: "Deep Ear Whisper", thumbNail: "w5", videoID: "9fqBaGzwDw8")
    let v6 = Video(authorName: "Fall Asleep Whisper", thumbNail: "w6",videoID: "vtF4VkRJ-iA")
return [v1,v2,v3,v4,v5,v6]
}
static func fetchTappingVideos() -> [Video] {

    let v1 = Video(authorName: "Addictive Tapping", thumbNail: "t1", videoID: "sIgkTYTWPz8")
    let v2 = Video(authorName: "Tapping", thumbNail: "t2",  videoID: "3x5PzivPJ3Q")
    let v3 = Video(authorName: "Massage Triggers", thumbNail: "t3", videoID: "QUlkoUqA21E")
     let v4 = Video(authorName: "Tingles", thumbNail: "t4", videoID: "yq5ud0t8tms")
     let v5 = Video(authorName: "Delicate tapping", thumbNail: "t5",  videoID: "jRZrSjIjXpo")
     let v6 = Video(authorName: "Tapping for Sleep", thumbNail: "t6", videoID: "PSjyJjucYis")
   
 return [v1,v2,v3,v4,v5,v6]
}
static func fetchPhysicalTouchVideos() -> [Video] {
    let v1 = Video(authorName: "Touch Face", thumbNail: "p1", videoID: "LAlhiKsj7rw")
    let v2 = Video(authorName: "Face touching", thumbNail: "p2",  videoID: "fI9setgbreo")
    let v3 = Video(authorName: "Touch your Face", thumbNail: "p3", videoID: "vOr649PWX6w")
     let v4 = Video(authorName: "Touching lens", thumbNail: "p4", videoID: "x-gOV7GmM5U")
     let v5 = Video(authorName: "Face touching", thumbNail: "p5",  videoID: "EFBo15l_Izo")
     let v6 = Video(authorName: "Face Treatment", thumbNail: "p6", videoID: "xqoRFiLOweo")
   
 return [v1,v2,v3,v4,v5,v6]
}
////////////
static func fetchPhysicalAttentionVideos() -> [Video] {

    let v1 = Video(authorName: "Pay Attention", thumbNail: "a1", videoID: "4D3Ao-TYCfg")
    let v2 = Video(authorName: "Nerve Exam", thumbNail: "a2",  videoID: "BAbAwhOzAOs")
    let v3 = Video(authorName: "Close Up", thumbNail: "a3", videoID: "Un0O3CycvEo")
     let v4 = Video(authorName: "Physical Exam", thumbNail: "a4", videoID: "avWY4UX1feQ")
     let v5 = Video(authorName: "Health Exam", thumbNail: "a5",  videoID: "vV1OVrKPnl8")
     let v6 = Video(authorName: "Check Up", thumbNail: "a6", videoID: "v_16VumazjA")
   
 return [v1,v2,v3,v4,v5,v6]}
    
static func fetchpageTurningVideos() -> [Video] {

    let v1 = Video(authorName: "Page turning", thumbNail: "q1", videoID: "uYXi3PJQAIQ")
    let v2 = Video(authorName: "Turning page", thumbNail: "q2",  videoID: "D5zbfYXZklw")
    let v3 = Video(authorName: "Old book turning", thumbNail: "q3", videoID: "6nbrPJu-q6w")
     let v4 = Video(authorName: "Newspaper turning", thumbNail: "q4", videoID: "dSANtgbvzfc")
     let v5 = Video(authorName: "Tracing", thumbNail: "q5",  videoID: "hwhvL1V0H8A")
     let v6 = Video(authorName: "Glossy Pages", thumbNail: "q6", videoID: "M-YY2VYmNR4")
   
 return [v1,v2,v3,v4,v5,v6]}
static func fetchRolePlayVideos() -> [Video] {

    let v1 = Video(authorName: "Flight attendant", thumbNail: "rp1", videoID: "dk5POe042DA")
    let v2 = Video(authorName: "First Class", thumbNail: "rp2",  videoID: "Jz4RIhuwMyk")
    let v3 = Video(authorName: "Hair Styling", thumbNail: "rp3", videoID: "BXDVfdcFCv8")
     let v4 = Video(authorName: "Make Up", thumbNail: "rp4", videoID: "SXRhGVpVMxI")
     let v5 = Video(authorName: "Eye Checking", thumbNail: "rp5",  videoID: "AJBaj5KZGzk")
     let v6 = Video(authorName: "Surgery", thumbNail: "rp6", videoID: "gxNI0ULcA74")
   
 return [v1,v2,v3,v4,v5,v6]
}
    static func fetchLightVideos() -> [Video] {

        let v1 = Video(authorName: "Follow the light", thumbNail: "l1", videoID: "RrnJ6y3l2XU")
        let v2 = Video(authorName: "Bright Light", thumbNail: "l2",  videoID: "BBfvSNGLSyM")
        let v3 = Video(authorName: "Light Trigger", thumbNail: "l3", videoID: "Y5np9HgKG8o")
         let v4 = Video(authorName: "Light Tracking", thumbNail: "l4", videoID: "bJSNZE83AEg")
         let v5 = Video(authorName: "Light Exam", thumbNail: "l5",  videoID: "fMO1lM050To")
         let v6 = Video(authorName: "Light Exam", thumbNail: "l6", videoID: "UZsNvbfL9So")
       
     return [v1,v2,v3,v4,v5,v6]
    }
////////////
static func fetchConcentrationVideos() -> [Video] {

    let v1 = Video(authorName: "Headache Relief", thumbNail: "c1", videoID: "s5_6NF1LhFM")
    let v2 = Video(authorName: "Intense Studying", thumbNail: "c2",  videoID: "0JdabeIQI6s")
    let v3 = Video(authorName: "Focus", thumbNail: "c3", videoID: "0inhxdjx20o")
     let v4 = Video(authorName: "Relax", thumbNail: "c4", videoID: "UuEMaRgAtZM")
     let v5 = Video(authorName: "Rainy Day Study", thumbNail: "c5",  videoID: "OE9YG_eUU-U")
     let v6 = Video(authorName: "Drawing", thumbNail: "c6", videoID: "EvOQc2iOKoE")
   
 return [v1,v2,v3,v4,v5,v6]}
static func fetchMassageVideos() -> [Video] {
    let v1 = Video(authorName: "Brain Massage", thumbNail: "m1", videoID: "sDKN7ZT5BNk")
    let v2 = Video(authorName: "Head Massage", thumbNail: "m2",  videoID: "ut4-EPDUPPM")
    let v3 = Video(authorName: "Oil Massage", thumbNail: "m3", videoID: "NKiYcuQnGxw")
     let v4 = Video(authorName: "Hand Massage", thumbNail: "m4", videoID: "rQmvYmRrgvY")
     let v5 = Video(authorName: "Foot Massage", thumbNail: "m5",  videoID: "ehKabhQifTM")
     let v6 = Video(authorName: "Skin Care", thumbNail: "m6", videoID: "57oY6EEkvaM")
   
 return [v1,v2,v3,v4,v5,v6]}
static func fetchRinklingVideos() -> [Video] {

    let v1 = Video(authorName: "Plastic", thumbNail: "z1", videoID: "2LriGE-b8Ho")
    let v2 = Video(authorName: "Powerful crinkles", thumbNail: "z2",  videoID: "VloNM5U5izs")
    let v3 = Video(authorName: "Crinkle Heaven", thumbNail: "z3", videoID: "RIJAWnZXhwc")
     let v4 = Video(authorName: "Unwrapping", thumbNail: "z4", videoID: "LxJyfa0liSU")
     let v5 = Video(authorName: "Satisfying Crinkles", thumbNail: "z5",  videoID: "Ak0dmNiEVHc")
     let v6 = Video(authorName: "Sensitive Crinkles", thumbNail: "z6", videoID: "0I2Qju1ccv4")
   
 return [v1,v2,v3,v4,v5,v6]
}

}
