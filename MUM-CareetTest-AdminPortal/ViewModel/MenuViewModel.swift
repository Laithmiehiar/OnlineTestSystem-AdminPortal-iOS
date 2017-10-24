//
//  MenuViewModel.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/12/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class MenuViewModel: NSObject{
    
    var list: NSArray? = ["CategoriesList","StudentsList"]

    func numberOfItemsInSection(section: Int)-> Int{
        return list?.count ?? 0
    }
    func titleForItemAtIndexPath(indexPath: IndexPath) -> String{
        return list?[indexPath.row] as? String ?? ""
    }
    
    
    
    
    
    
}
