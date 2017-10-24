//
//  studentResViewModel.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/21/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation
class studentResultViewModel: NSObject{
    @IBOutlet var webservice: webServiceClient!
    var studentRes: [StudentResultModel]?
    
    func getStudentResult(studentId: Int ,complition: @escaping() -> Void) {
        webservice.fetchStudentResult(studentId: studentId) { (result) in
            DispatchQueue.main.async {
                self.studentRes = result ?? nil
                complition()
            }
        }
    }
    
    func numberOfSectionToDisplay() -> Int {
        return self.studentRes?.count ?? 0
    }
    
    func numberOfSubItemsInACategoryToDisplay(in section: Int) -> Int {
        return self.studentRes?[section].grades.count ?? 0
    }
    
    func itemForDisplay(at indexPath: IndexPath) -> StudentGrades?{
            return studentRes?[indexPath.section].grades[indexPath.row] ?? nil
    }
    
}
