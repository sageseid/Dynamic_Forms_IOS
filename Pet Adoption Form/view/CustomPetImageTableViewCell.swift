//
//  CustomPetImageTableViewCell.swift
//  Pet Adoption Form
//
//  Created by Noel Obaseki on 30/08/2019.
//  Copyright © 2019 Tizeti. All rights reserved.
//

import UIKit

class CustomPetImageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var SBFormName: UILabel!
    
    @IBOutlet weak var SBFormImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
