//
//  Assignment.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/24/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation
struct Assignment{
    var id: Int
    var accessCode: String
    
    init(json: [String: Any]){
       self.id = json["id"] as? Int ?? -1
        self.accessCode = (json["accessCode"] as? String)!
    }
}
