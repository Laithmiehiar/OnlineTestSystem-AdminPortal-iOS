//
//  QuestionViewModel.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/24/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import Foundation

class QuestionViewModel: NSObject {
    
    @IBOutlet weak var webServiceClient: webServiceClient!
    
    var questions: [Question]?
    var result: Result?
    
    var searchQuestions =  [Match]()
    
    
    var language: String?
    
    let aux: Set<String> = ["be", "am", "are", "is", "was", "were", "being", "been", "can", "could", "dare", "do", "does", "did", "have", "has", "had", "having", "may", "might", "must", "need", "ought", "shall", "should", "will", "would", "these", "this", "those", "a", "an", "in", "into","from", "what", "which", "where"]
    
    
    func getQuestionList(subCatID: Int, completion: @escaping() -> Void ){
        webServiceClient.fetchQuestions(for: subCatID) { (ques) in
            self.questions = ques
            completion()
        }
    }
    
    
    
    func addQuestion(question: Data, completion: @escaping() -> Void) {
        webServiceClient.addQuestion(jsonData: question) { (res) in
            self.result = res
            completion()
        }
    }
    
    func numberOfSectionInQuestions() -> Int {
        return 1
    }
    
    func numberOfItemToDisplay(in section: Int) -> Int {
        return questions?.count ?? 0
    }
    
    func itemTodesplay(at indexPath: IndexPath) -> Question? {
        return questions?[indexPath.row]
    }
    
    
}

extension QuestionViewModel {
    fileprivate func setOfWords(string: String, language: inout String?) -> Set<String> {
        var wordSet = Set<String>()
        let tagger = NSLinguisticTagger(tagSchemes: [.lemma, .language], options: 0)
        let range = NSRange(location: 0, length: string.utf16.count)
        
        tagger.string = string
        if let language = language {
            
            let orthography = NSOrthography.defaultOrthography(forLanguage: language)
            tagger.setOrthography(orthography, range: range)
        } else {
            
            language = tagger.dominantLanguage
        }
        
        tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: [.omitPunctuation, .omitWhitespace]) { tag, tokenRange, _ in
            let token = (string as NSString).substring(with: tokenRange)
            
            wordSet.insert(token.lowercased())
            if let lemma = tag?.rawValue {
                
                wordSet.insert(lemma.lowercased())
            }
        }
        
        return wordSet
    }
    
    func match(wordSet1: Set<String>, wordSet2: Set<String>) -> Double {
        var counter = 0.0
        var w1 =  Set<String>()
        for word in wordSet1{
            if !aux.contains(word){
                w1.insert(word)
            }
        }
        
        
        
        for word in w1{
            if wordSet2.contains(word){
                counter = counter + 1
            }
        }
        
        print(w1)
        print(wordSet2)
        
        let count = Double(w1.count)
        return (counter/count)
    }
    
    func updateSerchQuestion(with text: String) {
        var temp = [Match]()
        guard let unwrappedQuestion = questions else{
            print("No data Found!!")
            return
        }
        
        for ques in unwrappedQuestion{
            let matchParcentage = match(wordSet1: setOfWords(string: ques.questionDesc, language: &language), wordSet2: setOfWords(string: text, language: &language))
            if matchParcentage > 0.5 {
                temp.append(Match(question: ques.questionDesc, parc: matchParcentage))
            }
        }
        searchQuestions = temp
        searchQuestions = searchQuestions.sorted()
    }
    
    func numberOfItemForDisplaySearch() -> Int{
        return searchQuestions.count
    }
    
    func itemToDispalyInSearchTable(at indexPath:IndexPath) -> String {
        return searchQuestions[indexPath.row].text
    }
    
}

extension QuestionViewModel {
    func getJsonData(question: Question, subCategory: SubCategory) -> Data?{
        var json: [String: Any] = [:]
        json["description"] = question.questionDesc
        var jsonSub: [String: Any] = [:]
        jsonSub["id"] = subCategory.id
        json["subcategory"] = jsonSub
        var jsonList = [[String: Any]]()
        
        for x in question.options{
            var jsonAnswer: [String: Any] = [:]
            jsonAnswer["description"] = x.description
            jsonAnswer["answer"] = x.answer ?? false
            jsonList.append(jsonAnswer)
        }
        json["choices"] = jsonList
        
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            print(jsonData.description)
            return jsonData
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
}
