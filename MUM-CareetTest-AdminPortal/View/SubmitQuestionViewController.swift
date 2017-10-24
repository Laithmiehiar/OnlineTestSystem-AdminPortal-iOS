//
//  SubmitQuestionViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/24/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class SubmitQuestionViewController: UIViewController {
    @IBOutlet weak var qiestionText: UITextView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: QuestionViewModel!
    
    var choiceNumber: Int = 2
    var answer: Int?
    
    var choices = [Option]()
    
    var subCatID: Int!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var questionBody: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qiestionText.text = questionBody
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addQuestion(_ sender: Any) {
        let cells = tableView.visibleCells
        var temp = [Option]()
        for cell in cells {
            var result: Bool?
            if cell.accessoryType == UITableViewCellAccessoryType.checkmark {
                result = true
            }else{
                result = false
            }
            let choice = Option(id: nil, description: (cell as! QuestionChoiceTableViewCell).textField.text!, answer: result)
            temp.append(choice)
        }
        choices = temp
        
        let question = Question(description: self.qiestionText.text, id: nil, choices: choices)
        let subCat = SubCategory(id: self.subCatID, name: nil)
        
        if self.answer == nil{
            let alert = UIAlertController(title: "Alert", message: "You need to select a answer" , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            viewModel.addQuestion(question: viewModel.getJsonData(question: question, subCategory: subCat)!) {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Alert", message: self.viewModel.result?.msg , preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    print(self.viewModel.result?.msg ?? "Submit Question viewModel.result no value")
                }
            }
        }
        
        
        
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            choiceNumber = 2
        case 1:
            choiceNumber = 3
        case 2:
            choiceNumber = 4
        case 3:
            choiceNumber = 5
        default:
            choiceNumber = 0
        }
        tableView.reloadData()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SubmitQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.choiceNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionChoiceCell", for: indexPath) as? QuestionChoiceTableViewCell{
            cell.questionNumber.text = "\(indexPath.row + 1)"
            cell.textField.placeholder = "Enter The Choice"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if(cell?.accessoryType == UITableViewCellAccessoryType.checkmark){
            cell?.accessoryType = UITableViewCellAccessoryType.none
            answer = nil
        }else{
            if answer != nil{
                let alert = UIAlertController(title: "Alert", message: "Can Have only one asnwer", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                cell?.accessoryType = UITableViewCellAccessoryType.checkmark
                answer = indexPath.row
            }
            
        }
    }
}

