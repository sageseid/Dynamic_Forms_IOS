//
//  CustomDynamicTableViewCell.swift
//  Pet Adoption Form
//
//  Created by Noel Obaseki on 01/09/2019.
//  Copyright © 2019 Tizeti. All rights reserved.
//

import UIKit
import  moa

class CustomDynamicTableViewCell: UITableViewCell {

    func updateViews(element_model : ElementsModel){
      createDynamicTableViewCell(element_model: element_model)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func createDynamicTableViewCell(element_model : ElementsModel){
        let typeOfCell = getTypeOfCell(element: element_model)
        switch typeOfCell {
        
        case "text":
            // create ui label
            let formLabelName  = UILabel()
            formLabelName.textColor  = .black
            formLabelName.translatesAutoresizingMaskIntoConstraints = false
            formLabelName.font = UIFont(name: "Avenir", size: 16)
            formLabelName.textAlignment = .left
            formLabelName.numberOfLines = 0
            formLabelName.text = element_model.label
            
            let formTextField = UITextField()
            formTextField.textColor = .black
            formTextField.backgroundColor = #colorLiteral(red: 0.4852389693, green: 0.4853243828, blue: 0.485227704, alpha: 1)
            formTextField.translatesAutoresizingMaskIntoConstraints = false
            formTextField.font = UIFont(name: "Avenir", size: 16)
            formTextField.textAlignment = .left
  
            addSubview(formLabelName)
            addSubview(formTextField)
            
            formLabelName.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
            formLabelName.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
            formLabelName.bottomAnchor.constraint(equalTo: formTextField.topAnchor, constant: -15).isActive = true
            formLabelName.rightAnchor.constraint(equalTo: rightAnchor , constant: 0).isActive = true
            formLabelName.heightAnchor.constraint(equalToConstant: 35).isActive = true
            
            formTextField.topAnchor.constraint(equalTo: formLabelName.bottomAnchor, constant: 10).isActive = true
            formTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
            formTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
            formTextField.rightAnchor.constraint(equalTo: rightAnchor , constant: 0).isActive = true
            formTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
            
            
        case "embeddedphoto":
            let imageName = "no_internet.jpg"
            let image = UIImage(named: imageName)
            let formImageView = UIImageView(image: image!)
            formImageView.moa.url = element_model.file
            formImageView.contentMode = .scaleAspectFit
        
            addSubview(formImageView)
            
            formImageView.topAnchor.constraint(equalTo: bottomAnchor, constant: 15).isActive = true
            formImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
            formImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
            formImageView.rightAnchor.constraint(equalTo: rightAnchor , constant: 0).isActive = true
            formImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            
        case "formattednumeric":
            
            let formLabelName  = UILabel()
            formLabelName.textColor  = .black
            formLabelName.translatesAutoresizingMaskIntoConstraints = false
            formLabelName.font = UIFont(name: "Avenir", size: 16)
            formLabelName.textAlignment = .left
            formLabelName.numberOfLines = 0
            formLabelName.text = element_model.label
            
            let formTextField = UITextField()
            formTextField.textColor = .black
            formTextField.backgroundColor = #colorLiteral(red: 0.4852389693, green: 0.4853243828, blue: 0.485227704, alpha: 1)
            formTextField.keyboardType = .numberPad
            formTextField.translatesAutoresizingMaskIntoConstraints = false
            formTextField.font = UIFont(name: "Avenir", size: 16)
            formTextField.textAlignment = .left
            
            addSubview(formLabelName)
            addSubview(formTextField)
            
            formLabelName.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
            formLabelName.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
            formLabelName.bottomAnchor.constraint(equalTo: formTextField.topAnchor, constant: -15).isActive = true
            formLabelName.rightAnchor.constraint(equalTo: rightAnchor , constant: 0).isActive = true
            formLabelName.heightAnchor.constraint(equalToConstant: 35).isActive = true
            
            formTextField.topAnchor.constraint(equalTo: formLabelName.bottomAnchor, constant: 10).isActive = true
            formTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
            formTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
            formTextField.rightAnchor.constraint(equalTo: rightAnchor , constant: 0).isActive = true
            formTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
            
            
        case "datetime":
            let formDatePicker = UIDatePicker()
            
            addSubview(formDatePicker)
            
            formDatePicker.topAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
            formDatePicker.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
            formDatePicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
            formDatePicker.rightAnchor.constraint(equalTo: rightAnchor , constant: 0).isActive = true
            formDatePicker.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
          
        case "yesno":
            
            let dropdown = DropDown()
            dropdown.placeholder = element_model.label
            dropdown.optionArray = ["Yes", "No"]
            dropdown.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(dropdown)
    
            dropdown.topAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
            dropdown.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
            dropdown.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
            dropdown.rightAnchor.constraint(equalTo: rightAnchor , constant: 0).isActive = true
            dropdown.heightAnchor.constraint(equalToConstant: 80).isActive = true
        default:
            print("not encountered type of cell in model given")
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func getTypeOfCell(element: ElementsModel) -> String {
        switch element.type {
        case "text":
            return "text"
        case "embeddedphoto":
            return "embeddedphoto"
        case "formattednumeric":
            return "formattednumeric"
        case "datetime":
            return "datetime"
        case "yesno":
            return "yesno"
        default:
            return "text"
        }
    }
    
    
    

}
