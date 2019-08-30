//
//  LocalDataService.swift
//  Pet Adoption Form
//
//  Created by Noel Obaseki on 30/08/2019.
//  Copyright © 2019 Tizeti. All rights reserved.
//

import Foundation
import SwiftyJSON

class LocalDataService {

        static var instance = LocalDataService()

    
    func getDataFromLocalJsonFile(){
    
        let path = Bundle.main.path(forResource: "pet_adoption", ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        let json = JSON(parseJSON: jsonString!)
        FormTitle = json["name"].stringValue
        if let data_arr = json["pages"].array{
            for item in data_arr{
                
              
            }
        }

   
    }
}
