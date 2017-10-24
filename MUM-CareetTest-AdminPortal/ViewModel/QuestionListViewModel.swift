//
//  QuestionListViewModel.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/15/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation

class QuestionListViewModel: NSObject{
    @IBOutlet var webservice: webServiceClient!
    var questions: [Question]?
    var questionNumber = 0
    var answers = [Int: Int?]()
    
    func getQuestionList(subCatList: [Int], complition: @escaping() -> Void) {
        
        webservice.fetchQuestion(subCatList: subCatList) { (arrayOfQuestions) in
            DispatchQueue.main.async {
                self.questions = arrayOfQuestions
                complition()
            }
        }
    }
    
    func numberOfRowsInSection(section: Int)-> Int{
        return self.questions?.count ?? 0
    }
    func itemForDisplay(at indexPath: IndexPath) -> Question?{
        return self.questions?[indexPath.row] ?? nil
    }
    
    
    
    
}
