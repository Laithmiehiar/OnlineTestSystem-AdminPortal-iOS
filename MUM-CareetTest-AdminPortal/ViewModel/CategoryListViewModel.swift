//
//  CategoryListViewModel.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/14/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class CategoryListViewModel: NSObject{
    @IBOutlet var webservice: webServiceClient!
        var categoriesArray: [Category]?

    func getdata (onCompletion:@escaping (Bool, Any?, Error?)-> Void){

        webservice.fetchCatagory(){ categoies in
            guard categoies != nil else {
                print("Error getting data")
                onCompletion(false,nil, nil)
                return
            }
            self.categoriesArray = categoies
                print("Category list: \(String(describing: self.categoriesArray))")
                onCompletion(true,self.categoriesArray,nil)

        }

    }
    
    func numberOfSectionToDisplay() -> Int {
        return self.categoriesArray?.count ?? 0
    }
    
    func numberOfSubItemsInACategoryToDisplay(in section: Int) -> Int {
        return self.categoriesArray?[section].subcategories.count ?? 0
    }
    
    func itemForDisplay(at indexPath: IndexPath) -> SubCategory?{
        return categoriesArray?[indexPath.section].subcategories[indexPath.row] ?? nil
    }
    
}

