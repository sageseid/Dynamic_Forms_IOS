//
//  PetAdoptionPageOne_VC.swift
//  Pet Adoption Form
//
//  Created by Noel Obaseki on 30/08/2019.
//  Copyright © 2019 Tizeti. All rights reserved.
//

import UIKit

class PetAdoptionPageOne_VC: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
   
    

    @IBOutlet weak var SBPetAdoptionPageOneTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SBPetAdoptionPageOneTableView.dataSource = self
        SBPetAdoptionPageOneTableView.delegate = self
    }
    
    
    //code to instantiate the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 5
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "firstCustomCell")
//            //set the data here
//            return cell
//        }
//        else if indexPath.row == 1 {
//            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "secondCustomCell")
//            //set the data here
//            return cell
//        }
//        else if indexPath.row == 2 {
//            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "secondCustomCell")
//            //set the data here
//            return cell
//        }
//        else if indexPath.row == 3 {
//            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "secondCustomCell")
//            //set the data here
//            return cell
//        }
//        else {
//            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "thirdCustomCell")
//            //set the data here
//            return cell
//        }
    }
    
}
