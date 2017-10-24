//
//  webServiceClient.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/10/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class webServiceClient: NSObject{
    
    func authenticateUser(usernamex:String, passwordx:String, onCompletion: @escaping (Bool, Any?, Error?)-> Void){
        
        guard let url = URL(string: BASE_URL+LOGIN_URL+"username=\(usernamex)&password=\(passwordx)") else {
            print("Error unwrapping URL"); return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            
            //5 - unwrap our returned data
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    //7 - create an array of dictionaries from
                    if let userInfo = responseJSON.value(forKeyPath: "product") as? [NSDictionary] {
                        //8 - set the completion handler with our apps array of dictionaries
                        onCompletion(true,userInfo, nil)
                    }
                }
            } catch {
                //9 - if we have an error, set our completion with nil
                onCompletion(false,nil, error)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        //10 -
        dataTask.resume()
    }
    
}
extension webServiceClient {
    
    func fetchCatagory(completion: @escaping([Category]?) -> Void) {
        print("API Call")
        guard let url = URL(string: BASE_URL2+catlink) else {
            print("Error unwrapping URL")
            return
        }
        
        /*var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.httpBody = "accessCode=\(code)".data(using: .utf8)
         
         print(request)*/
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else {
                print("Error getting data")
                return
            }
            
            //print(unwrappedData)
            
            do{
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? [[String: Any]]{
                    
                    //print(responseJSON)
                    
                    //let accessCodeResponse: AccessCodeResponse = AccessCodeResponse(json: responseJSON)
                    
                    var categories: [Category] = []
                    for response in responseJSON {
                        categories.append(Category(json: response))
                    }
                    completion(categories)
                    print(categories)
                }
            }catch{
                completion(nil)
                print("Error getting API Data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    
}

    }
extension webServiceClient {
    func fetchQuestion(subCatList: [Int], completion: @escaping([Question]?) -> Void) {
        guard let url = URL(string: BASE_URL+qest) else {
            print("Error unwrapping URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        let formattedArray = (subCatList.map{String($0)}).joined(separator: ",")
        request.httpBody = "param=\(formattedArray)".data(using: .utf8)
        

        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let unwrappeData = data else {
                print("Error geting data")
                return
            }
            
            print(unwrappeData.description)
            
            do{
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappeData, options: .allowFragments) as? [[String: Any]] {
                    var questions = [Question]()
                    for response in responseJSON {
                        questions.append(Question(json: response))
                    }
                    completion(questions)
                }
            }catch{
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
}
extension webServiceClient {
    func fetchQuestions(for subCat: Int, completion: @escaping([Question]?) -> Void) {
        guard let url = URL(string: BASE_URL2 + "getAllQuestionForSubCat") else {
            print("Error unwrapping URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "subCatId=\(subCat)".data(using: .utf8)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let unwrappeData = data else {
                print("Error geting data")
                return
            }
            
            print(unwrappeData.description)
            
            do{
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappeData, options: .allowFragments) as? [[String: Any]] {
                    var questions = [Question]()
                    for response in responseJSON {
                        questions.append(Question(json: response))
                    }
                    completion(questions)
                    print(questions)
                }
            }catch{
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
}

extension webServiceClient {
    func addQuestion(jsonData: Data?, completion: @escaping(Result?) -> Void) {
        guard let data = jsonData else{
            return
        }
        guard let url = URL(string: BASE_URL2+addQuestionRef) else {
            print("Error unwrapping URL")
            return
        }
        
        print("Going to Submit Result")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //print(data.)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)  { (data, response, error) in
            guard let res = response as? HTTPURLResponse else {
                return
            }
            if res.statusCode >= 200 && res.statusCode <= 299 {
                print("success")
            }
            
            guard let unwrappedData = data else{
                print("No Data Found")
                return
            }
            
            do{
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? [String: Any] {
                    let result = Result(json: responseJSON)
                    completion(result)
                }
                
            }catch{
                completion(nil)
                print("Error getting API Data \(error.localizedDescription)")
                
            }
            
        }
        dataTask.resume()
    }
}
extension webServiceClient {
    func fetchAllStudent(completion: @escaping([Student]?) -> Void) {
        guard let url = URL(string: BASE_URL2+getAllStudent) else {
            print("Error unwrapping URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let unwrappeData = data else {
                print("Error geting data")
                return
            }
            
            print(unwrappeData.description)
            
            do{
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappeData, options: .allowFragments) as? [[String: Any]] {
                    var student = [Student]()
                    for response in responseJSON {
                        student.append(Student(data: response))
                    }
                    completion(student)
                    print(student)

                }
            }catch{
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
}

extension webServiceClient{
    func postNewStudent(jsonData: Data?, completion: @escaping(Bool, Any?, Error?) -> Void) {
        guard let data = jsonData else{
            return
        }
        guard let url = URL(string: BASE_URL2 + addStudent) else {
            print("Error unwrapping URL")
            return
        }
        
        print("Going to Submit Student")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //print(data.)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)  { (data, response, error)    in
            guard let res = response as? HTTPURLResponse else {
                return
            }
            if res.statusCode >= 200 && res.statusCode <= 299 {
                completion(true, res,nil)
                print("success")
            }
        }
        dataTask.resume()
    }
    
}
extension webServiceClient {
    func fetchStudentResult(assignmentId: Int, completion: @escaping([StudentResultModel]?) -> Void) {
        guard let url = URL(string: BASE_URL2+studentResult) else {
            print("Error unwrapping URL")
            return
        }
        
        print("url: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "studentid=\(assignmentId)".data(using: .utf8)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let unwrappeData = data else {
                print("Error geting data")
                return
            }
            
            do{
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappeData, options: .allowFragments) as? [[String: Any]] {
                    var studentResult = [StudentResultModel]()
                    for response in responseJSON {
                        studentResult.append(StudentResultModel(json: response))
                    }
                    completion(studentResult)
                }
            }catch{
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
}
