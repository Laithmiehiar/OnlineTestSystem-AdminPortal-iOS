//
//  StudentGrades.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/23/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation
struct StudentGrades{
    var name : String
    var grade: String
    
    init(json: [String: Any]){
        let key = json.keys.first
        self.name = key ?? "No Des"
        self.grade = json[key!] as? String ?? "No Des"
    }
}
