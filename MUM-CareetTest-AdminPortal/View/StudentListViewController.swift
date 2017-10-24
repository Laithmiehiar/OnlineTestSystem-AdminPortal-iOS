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
             performSegue(withIdentifier: "studentInfo", sender: student)
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "studentInfo"){
            print(segue.identifier!)
            let destinationVC = segue.destination as! StudentResultViewController
            destinationVC.student = sender as? Student
            
        }
    }
}

