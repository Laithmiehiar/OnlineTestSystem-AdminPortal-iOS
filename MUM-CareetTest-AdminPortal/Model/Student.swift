//
//  Student.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/19/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation
struct Student{
    let userId: Int
    let email: String
    let username: String
    let firstName: String
    let lastName: String
    let studentId: String
    let entry: String
    let jobSearchStatus: Bool
    var assignmentData: [Assignment] = []
    init(data: [String: Any]) {
        
        userId  = data["userId"] as? Int ?? -1
        email  = data["email"] as? String ?? ""
        username  = data["username"] as? String ?? ""
        firstName  = data["firstname"] as? String ?? ""
        lastName  = data["lastname"] as? String ?? ""
        studentId  = data["studentId"] as? String ?? ""
        entry  = data["entry"] as? String ?? ""
        jobSearchStatus  = data["jobSearchStatus"] as? Bool ?? false
        let assign  = data["assignmentJson"] as? [[String: Any]] ?? [[:]]
        for assignment in assign{
            self.assignmentData.append(Assignment(json: assignment))
        }
    }
    
    
}
