//
//  AssignmentListViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/24/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class AssignmentListViewController: UIViewController{
    
    @IBOutlet weak var tableview: UITableView!
    var student: Student!
    
    override func viewDidLoad() {
        tableview.delegate = self
        tableview.dataSource = self
    }
}


extension AssignmentListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return student.assignmentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "assignmentListCell", for: indexPath) as! AssignmentListCustomeCell
        configureCell(cell: cell, forRowaAtItemIndex: indexPath)
        return cell
        
    }
    
    
    func configureCell(cell: AssignmentListCustomeCell, forRowaAtItemIndex indexPath: IndexPath){
        cell.assignmentNo.text = "\(indexPath.row+1)"
        cell.accessCode.text  = student.assignmentData[indexPath.row].accessCode 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let assignment = student.assignmentData[indexPath.row]
        performSegue(withIdentifier: "studentInfo", sender: assignment)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "studentInfo"){
            print(segue.identifier!)
            let destinationVC = segue.destination as! StudentResultViewController
            destinationVC.assignment = sender as? Assignment
            
        }
        
    }
}
