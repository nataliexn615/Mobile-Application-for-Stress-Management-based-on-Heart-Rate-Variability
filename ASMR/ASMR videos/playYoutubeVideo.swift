//
//  playYoutubeVideo.swift
//  ASMR
//
//  Created by Ying Nam lee on 16/3/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class playYoutubeVideo: UIViewController{
    @IBOutlet var myPlayerr: YTPlayerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        myPlayerr.load(withVideoId:displayVideo.choseVideo)
}
    @IBAction func finished(_ sender: Any) {
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "emotiondetection")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
   


