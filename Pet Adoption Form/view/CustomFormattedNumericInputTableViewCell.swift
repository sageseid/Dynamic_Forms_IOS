//
//  CustomFormattedNumericInputTableViewCell.swift
//  Pet Adoption Form
//
//  Created by Noel Obaseki on 30/08/2019.
//  Copyright © 2019 Tizeti. All rights reserved.
//

import UIKit

class CustomFormattedNumericInputTableViewCell: UITableViewCell {

    @IBOutlet weak var SBFormLabel: UILabel!
    
    @IBOutlet weak var SBFormFormattedNumberTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
