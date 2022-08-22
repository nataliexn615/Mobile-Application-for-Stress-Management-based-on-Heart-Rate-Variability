//
//  VideoMenuTableViewController.swift
//  FirebaseAuth
//
//  Created by Ying Nam lee on 23/1/2021.
//

import UIKit
var pets = ["Whispering", "Tapping", "Physical Touch","physicalAttention","pageTurninglight","light", "roleplay",
"eating","concentration","massage","rinkling"]

class ASMRmenu: UITableViewController {
    override func viewDidLoad() {
        title = "ASMR Category"
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    static var getASMRCat: String = ""
    static var myIndex = 0
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Pick your favourite"
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
