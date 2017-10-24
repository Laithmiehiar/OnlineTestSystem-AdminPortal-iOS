//
//  Option.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/10/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation

struct Option {
    let id: Int
    let description: String
    let answer: Bool
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        description = json["description"] as? String ?? ""
        answer = json["answer"] as? Bool ?? false
    }
}
