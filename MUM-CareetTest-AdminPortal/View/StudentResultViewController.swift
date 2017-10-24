//
//  StudentResultViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/21/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit
class StudentResultViewController: UIViewController{
    @IBOutlet var studentResultViewModel: studentResultViewModel!
    @IBOutlet weak var tableview: UITableView!
    var student: Student!
   
    override func viewDidLoad() {
        tableview.dataSource = self as UITableViewDataSource
        tableview.delegate = self as UITableViewDelegate
        
        studentResultViewModel.getStudentResult(studentId: student.userId){
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
}

extension StudentResultViewController: UITableViewDataSource, UITableViewDelegate{
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return studentResultViewModel.numberOfSectionToDisplay()
    }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let text = "answers:\(studentResultViewModel.studentRes![section].total) | Qestions: \(studentResultViewModel.studentRes![section].questions) | Grade: \(studentResultViewModel.studentRes![section].grade)"
        return text
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentResultViewModel.numberOfSubItemsInACategoryToDisplay(in: section)
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentresultcell", for: indexPath) as? StudentResultCell
        configureCell(cell: cell!, forRowaAtItemIndex: indexPath)
        return cell!
    }
    
    func configureCell(cell: StudentResultCell, forRowaAtItemIndex indexPath: IndexPath){
        cell.topic.text  = studentResultViewModel.itemForDisplay(at: indexPath)?.name
        cell.result.text = studentResultViewModel.itemForDisplay(at: indexPath)?.grade
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        
}

}

