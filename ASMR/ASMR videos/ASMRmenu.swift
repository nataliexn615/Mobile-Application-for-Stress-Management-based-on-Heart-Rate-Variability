//
//  ASMRmenu.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit
var pets = ["Whispering", "Tapping", "Physical Touch","Physical Attention","Page Turning","Light", "Roleplay","Eating","Concentration","Massage","Crinkling"]

class ASMRmenu: UITableViewController {
    override func viewDidLoad() {
        title = "ASMR Category"
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    static var getASMRCat: String = ""
    static var myIndex = 0

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return pets.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = pets[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ASMRmenu.myIndex = indexPath.row
        ASMRmenu.getASMRCat = pets[indexPath.row]
        let vc: UIViewController = storyboard!.instantiateViewController(withIdentifier: "displayVideo")
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)


    }
}
