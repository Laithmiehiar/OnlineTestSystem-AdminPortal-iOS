//
//  QuestionDetailsViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/17/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class QuestionDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var question: Question!
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var questionText: UITextView!
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        questionText.text = question.questionDesc
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.question.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chociesCell", for: indexPath) as UITableViewCell
        configureCell(cell: cell, forRowaAtItemIndex: indexPath)
        return cell
        
    }
    
    func configureCell(cell: UITableViewCell, forRowaAtItemIndex indexPath: IndexPath){
        if question.options[indexPath.row].answer! {
            cell.textLabel?.textColor = UIColor.red
        }
        cell.textLabel?.text = self.question.options[indexPath.row].description
    }
}
