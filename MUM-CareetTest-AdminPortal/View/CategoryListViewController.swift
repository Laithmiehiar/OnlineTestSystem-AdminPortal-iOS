//
//  CategoryListViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/14/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class CategoryListViewController: UITableViewController{
    
    @IBOutlet var categoryListViewModel: CategoryListViewModel!
    
    override func viewDidLoad() {
        print("sad")
        categoryListViewModel.getdata() { _,_,_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "questionsListSeguee"){
            print(segue.identifier!)
            let nav = segue.destination as! UINavigationController
            if let destinationVC = nav.topViewController as? QuestionListViewController{
                destinationVC.subCategory = sender as? SubCategory
            }
        }
        
    }
    
}

extension CategoryListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categoryListViewModel.numberOfSectionToDisplay()
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryListViewModel.categoriesArray![section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryListViewModel.numberOfSubItemsInACategoryToDisplay(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryListCell", for: indexPath) as UITableViewCell
        configureCell(cell: cell, forRowaAtItemIndex: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowaAtItemIndex indexPath: IndexPath){
        cell.textLabel?.text = categoryListViewModel.itemForDisplay(at: indexPath)?.name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subcat = categoryListViewModel.itemForDisplay(at: indexPath)
        performSegue(withIdentifier: "questionsListSeguee", sender: subcat)
        
    }
}

