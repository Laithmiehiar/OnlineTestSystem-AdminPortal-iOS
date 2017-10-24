//
//  Result.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/24/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation

struct Result {
    let result: String
    let msg: String
    let accessCode: String?
    
    init(json: [String: Any]) {
        self.result = json["result"] as? String ?? "false"
        self.msg = json["msg"] as? String ?? "no value"
        self.accessCode = json["accessCode"] as? String
    }
    
    init(){
        self.result = "false"
        self.msg = "Nothing saved"
        self.accessCode = nil
    }
}
