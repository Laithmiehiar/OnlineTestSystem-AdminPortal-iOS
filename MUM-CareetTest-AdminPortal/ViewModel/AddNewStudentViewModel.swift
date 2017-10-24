//
//  AddNewStudentViewModel.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/19/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation
class AddNewStudentViewModel: NSObject{
    @IBOutlet var webservice: webServiceClient!
    var answers = [String: String?]()
    var jobSearchStatus = ["Active", "InActive"];
    
    func pushData(studentInfo : [String: String?],completion: @escaping(Bool, Any?, Error?) -> Void){
//        var json: [String: Any] = [:]
//        json["accesCode"] = "ACCESS_CODE"
//
//        var jsonList: [[String: Any]] = []
//
//        for x in answers{
//            var jsonAnswer: [String: Any] = [:]
//            jsonAnswer["question"] = x.key
//            jsonAnswer["ans"] = x.value
//            jsonList.append(jsonAnswer)
//        }
//
//
//        json["resultList"] = jsonList
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: studentInfo, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            webservice.postNewStudent(jsonData: jsonData){ (data, response, error)  in
                print(response ?? "fff")
                completion(data, response, error)
            }
            print(jsonData.description)
//            return jsonData
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func numberOfComponentsInPickerView()-> Int{
        return 1
    }
    
    func numberOfRowsInComponent()-> Int{
        return jobSearchStatus.count
    }
    func titleForRow(row: Int) -> String{
        return jobSearchStatus[row]
    }
    
    
}
