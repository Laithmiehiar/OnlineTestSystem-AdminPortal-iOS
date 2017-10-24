//
//  StudentListViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/14/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit
class StudentListViewController: UIViewController{
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var studentListViewModel: StudentListViewModel!
    
    override func viewDidLoad() {
        tableview.dataSource = self as UITableViewDataSource
        tableview.delegate = self as UITableViewDelegate
        
        
        studentListViewModel.getStudentList(){
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    func alertDialogPopup(alertTitle: String, alertMessage: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension StudentListViewController : UITableViewDelegate, UITableViewDataSource{
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return studentListViewModel.numberOfRowsInSection(section: section)
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "studentListCell", for: indexPath)
            let student = studentListViewModel.itemForDisplay(at: indexPath)
            cell.textLabel?.text =  "\(String(describing: student?.firstName ?? "")) \(String(describing: student?.lastName ?? ""))"
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let student = studentListViewModel.itemForDisplay(at: indexPath)
            if((student?.assignmentData.count)! > 0){
             performSegue(withIdentifier: "assignmentList", sender: student)
            }else{
                alertDialogPopup(alertTitle: "Warning!", alertMessage: "No Assignment yet for this student", buttonTitle: "Ok")
            }
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "assignmentList"){
            print(segue.identifier!)
            let destinationVC = segue.destination as! AssignmentListViewController
            destinationVC.student = sender as? Student
            
        }
    }
}

