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
    
    init(json: (key: String, value: Any)){
//        let key = json.keys.first
        self.name = json.key as String
//        self.grade = json[(key)!] as? String ?? "No Des"
        self.grade = json.value as? String ?? "No Value"
    }
}
