//
//  RelaxViewController.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit

class RelaxViewController: UIViewController {

    @IBOutlet weak var gotoASMR: UIButton!
    
    @IBOutlet weak var beginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginButton.layer.cornerRadius = 10
        gotoASMR.layer.cornerRadius = 10
    }
    
}
