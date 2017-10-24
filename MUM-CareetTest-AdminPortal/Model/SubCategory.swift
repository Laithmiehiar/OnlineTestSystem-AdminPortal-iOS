//
//  SubCategory.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/10/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation

struct SubCategory {
    var id: Int
    var name: String?
    var enabled: Bool
    var categoryId: Int
    var questionCount: Int
    var category: String
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        enabled = json["enabled"] as? Bool ?? false
        categoryId = json["categoryId"] as? Int ?? -1
        questionCount = json["questionCount"] as? Int ?? -1
        category = json["category"] as? String ?? ""
    }
    init(id: Int, name: String?) {
        self.id = id
        self.name = name
        enabled = false
        categoryId = -1
        questionCount = 0
        category =  ""
    }
}
