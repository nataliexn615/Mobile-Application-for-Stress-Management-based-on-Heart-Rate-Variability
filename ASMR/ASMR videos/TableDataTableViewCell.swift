//
//  TableDataTableViewCell.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit
class TableDataTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var controlview: UIView!
    var video: Video!{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        thumbnailImageView.image = UIImage(named: video.thumbNail)
   
        thumbnailImageView.layer.cornerRadius = 15
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.masksToBounds = true
        usernameLabel.text = video.authorName
     }
}
