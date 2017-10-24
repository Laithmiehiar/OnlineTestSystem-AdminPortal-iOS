//
//  MenuViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/12/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController{
    
    @IBOutlet var menuViewModel: MenuViewModel!
    override func viewDidLoad() {
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuViewModel.numberOfItemsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        configureCell(cell: cell, forRowaAtItemIndex: indexPath)
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case indexPath.row = 0{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "categoriesListSegue", sender: self)
            }
        }else if case indexPath.row = 1{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "studentListSegue", sender: self)

            }
        }
        
    }
    func configureCell(cell: UITableViewCell, forRowaAtItemIndex indexPath: IndexPath){
        cell.textLabel?.text = menuViewModel.titleForItemAtIndexPath(indexPath: indexPath)
    }
    
   
    
    
}
