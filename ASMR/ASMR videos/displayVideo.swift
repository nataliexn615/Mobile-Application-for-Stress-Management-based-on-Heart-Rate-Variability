//
//  displayVideo.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class displayVideo: UITableViewController{
 
    let fetchIndex = ASMRmenu.myIndex
    var videos: [Video] = Video.fetchEatingVideos()

    override func viewDidLoad() {
        super.viewDidLoad()

    switch fetchIndex{
    case 0:
       videos = Video.fetchWhisperingVideos()
    case 1:
      videos = Video.fetchTappingVideos()
    case 2:
        videos = Video.fetchPhysicalTouchVideos()
    case 3:
        videos = Video.fetchPhysicalAttentionVideos()
    case 4:
       videos = Video.fetchpageTurningVideos()
    case 5:
        videos = Video.fetchLightVideos()
    case 6:
      videos = Video.fetchRolePlayVideos()
    case 7:
        videos = Video.fetchEatingVideos()
    case 8:
        videos = Video.fetchConcentrationVideos()
    case 9:
       videos = Video.fetchMassageVideos()
    case 10:
      videos = Video.fetchRinklingVideos()

    default:
        print("default")
    }
        

}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! TableDataTableViewCell
        let video = videos[indexPath.row]

        cell.video = video
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        playVideo(at: indexPath)
    }
    static var choseVideo = ""
    func playVideo(at indexPath: IndexPath){
      
        let selectedVideo = videos[indexPath.row]
        
        displayVideo.choseVideo = selectedVideo.videoID
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "playYoutubeVideo")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }

}
