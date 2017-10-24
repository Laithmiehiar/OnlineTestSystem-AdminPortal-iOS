//
//  AddQuestionViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/18/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: QuestionViewModel!
    @IBOutlet weak var searchBar: UISearchBar!
    var subCatID: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        performSegue(withIdentifier: "SubmitQuestion", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "SubmitQuestion"){
            if let destinationVC = segue.destination as? SubmitQuestionViewController {
                //destinationVC.subCategoryIds = self.subCategoriesList
                destinationVC.viewModel = self.viewModel
                destinationVC.questionBody = self.searchBar.text
                destinationVC.subCatID = self.subCatID
                
            }
        }
        
        
    }
    
    
}

extension AddQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemForDisplaySearch()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchQuestionCell", for: indexPath)
        
        cell.textLabel?.text = viewModel.itemToDispalyInSearchTable(at: indexPath)
        
        return cell
    }
}

extension AddQuestionViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            print("No Text Typped")
            return
        }
        print("Text Change")
        
        viewModel.updateSerchQuestion(with: text)
        print(viewModel.searchQuestions)
        tableView.reloadData()
    }
}

