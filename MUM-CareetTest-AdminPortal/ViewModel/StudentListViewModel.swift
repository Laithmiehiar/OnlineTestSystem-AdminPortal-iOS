//
//  StudentListViewModel.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/14/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class StudentListViewModel: NSObject{
    @IBOutlet var webservice: webServiceClient!
    var students: [Student] = []
    
    func getStudentList(complition: @escaping() -> Void) {
        webservice.fetchAllStudent() { (arrayOfStudent) in
            DispatchQueue.main.async {
                self.students = arrayOfStudent!
                complition()
            }
        }
    }
    
    func numberOfRowsInSection(section: Int)-> Int{
        return self.students.count
    }
    
    func itemForDisplay(at indexPath: IndexPath) -> Student?{
        return self.students[indexPath.row]
    }
    
}
