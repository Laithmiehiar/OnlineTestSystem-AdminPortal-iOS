//
//  QuestionListViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/15/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class QuestionListViewController: UITableViewController{
    @IBOutlet var questionViewModel: QuestionListViewModel!
    var subCategory: SubCategory?
    
    override func viewDidLoad() {
        
        print(subCategory?.name ?? "asd")
        questionViewModel.getQuestionList(subCatList:([(subCategory?.id)!])) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionViewModel.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as UITableViewCell
        configureCell(cell: cell, forRowaAtItemIndex: indexPath)
        return cell
        
    }
    
    
    func configureCell(cell: UITableViewCell, forRowaAtItemIndex indexPath: IndexPath){
        cell.textLabel?.text = questionViewModel.itemForDisplay(at: indexPath)?.questionDesc
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get the question that has been clicked
        let question = questionViewModel.itemForDisplay(at: indexPath)
          performSegue(withIdentifier: "showQuestionDetails", sender: question)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showQuestionDetails"){
            print(segue.identifier!)
            let destinationVC = segue.destination as! QuestionDetailsViewController
                destinationVC.question = sender as? Question
            
        }else if (segue.identifier == "showAddQuestion"){
            let destinationVC = segue.destination as! AddQuestionViewController
            destinationVC.subCategory = sender as? SubCategory
            
        }
    }
}
