//
//  Questions.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/10/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation
struct Question {
    
    var id: Int
    var questionDesc: String
    var options: [Option] = []
//    var subCategoryId: Int
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        questionDesc = json["description"] as? String ?? ""
        let choicesJson = json["choices"] as? [[String: Any]] ?? [[:]]
        for choice in choicesJson{
            options.append(Option(json: choice))
        }
    }
}
