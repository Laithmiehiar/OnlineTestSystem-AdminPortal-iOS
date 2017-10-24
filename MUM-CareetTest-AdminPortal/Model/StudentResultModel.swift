//
//  StudentResultModel.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/21/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation
struct StudentResultModel{
    var grades: [StudentGrades] = []
    var total: String
    var questions: String
    var grade: String
    
    init(json: [String: Any]) {
        let temp = json["grades"] as? [[String:Any]] ?? [[:]]
        for c in temp{
            self.grades.append(StudentGrades(json: c))
        }
        total = json["total"] as? String ?? ""
        questions = json["questions"] as? String ?? ""
        grade = json["grade"] as? String ?? ""
    }
}
