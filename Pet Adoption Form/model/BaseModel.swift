//
//  BaseModel.swift
//  Pet Adoption Form
//
//  Created by Noel Obaseki on 31/08/2019.
//  Copyright © 2019 Tizeti. All rights reserved.
//

import Foundation
struct BaseModel: Codable {
    let id: String
    let name: String
    let pages: [PagesModel]
}

struct PagesModel: Codable {
    let label: String
    let sections: [SectionsModel]
}

struct SectionsModel: Codable {
    let label: String
    let elements: [ElementsModel]
}

struct ElementsModel: Codable {
    let type: String?
    let label: String?
    let file: String?
    let keyboard: String?
    let formattedNumeric: String?
    let isMandatory: Bool?
    let unique_id: String?
    let rules: [RulesModel]?
}


struct RulesModel: Codable {
    let condition: String?
    let value: String?
    let action: String?
    let otherwise: String?
    let targets: [String]?
}
