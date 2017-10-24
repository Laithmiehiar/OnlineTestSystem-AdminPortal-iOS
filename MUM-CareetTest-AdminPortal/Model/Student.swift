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
    let password: String
    let enabled: Bool
//    let authorites: NSArray
    let studentId: String
    let entry: String
    let jobSearchStatus: Bool
    
    init(data: [String: Any]) {
        userId  = data["userId"] as? Int ?? -1
        email  = data["email"] as? String ?? ""
        username  = data["username"] as? String ?? ""
        firstName  = data["firstName"] as? String ?? ""
        lastName  = data["lastName"] as? String ?? ""
        password  = data["password"] as? String ?? ""
        enabled  = data["enabled"] as? Bool ?? false
        studentId  = data["studentId"] as? String ?? ""
        entry  = data["entry"] as? String ?? ""
        jobSearchStatus  = data["jobSearchStatus"] as? Bool ?? false
    }
    
    
}
