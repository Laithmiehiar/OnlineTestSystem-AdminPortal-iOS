//
//  Category.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/15/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation

struct Category {
    var id: Int
    var name: String
    var subcategories: [SubCategory] = []
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        let subCategoriesFromJson = json["subcategories"] as? [[String:Any]] ?? []
        for sub in subCategoriesFromJson {
            subcategories.append(SubCategory(json: sub))
        }
    }
}

