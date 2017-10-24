//
//  AddNewStudentViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/19/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class AddNewStudentViewController: UIViewController{
    @IBOutlet var addNewStudentViewModel: AddNewStudentViewModel!
    
    @IBOutlet weak var firstNameEd: UITextField!
    @IBOutlet weak var lastNameEd: UITextField!
    @IBOutlet weak var emailEd: UITextField!
    @IBOutlet weak var studentId: UITextField!
    @IBOutlet weak var entryYearEd: UITextField!
    var studentInfo = [String: String?]()

    var searchStatus: String!
    @IBOutlet weak var jobSearchStatusPicker: UIPickerView!
    
    override func viewDidLoad() {
        self.jobSearchStatusPicker.dataSource = self as UIPickerViewDataSource
        self.jobSearchStatusPicker.delegate = self as UIPickerViewDelegate
    }
  
    @IBAction func SubmitAddStudent(_ sender: Any) {
        guard firstNameEd.text ?? "" != "" else{
            firstNameEd.attributedPlaceholder = NSAttributedString(string: "Please type your firstname ",
                                                                    attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            return
        }
        guard lastNameEd.text ?? "" != "" else{
            lastNameEd.attributedPlaceholder = NSAttributedString(string: "Please type your lastname ",
                                                                    attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            return
        }
        
        guard emailEd.text ?? "" != "" else{
            emailEd.attributedPlaceholder = NSAttributedString(string: "Please type your email ",
                                                                    attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            return
        }
        guard studentId.text ?? "" != "" else{
            studentId.attributedPlaceholder = NSAttributedString(string: "Please type Student Id",
                                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            return
        }
        
        guard entryYearEd.text ?? "" != "" else{
            entryYearEd.attributedPlaceholder = NSAttributedString(string: "Please type your entry date ",
                                                                    attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            return
        }
        
        studentInfo["firstName"] = firstNameEd.text
        studentInfo["lastName"] = lastNameEd.text
        studentInfo["email"] = emailEd.text
        studentInfo["studentId"] = studentId.text
        studentInfo["entry"] = entryYearEd.text
        studentInfo["jobSearchStatus"] = self.searchStatus
        
        addNewStudentViewModel.pushData(studentInfo: studentInfo){ (data, response, error) in
           print(data)
            if data{
                DispatchQueue.main.async {
                    self.firstNameEd.text = ""
                    self.lastNameEd.text = ""
                    self.emailEd.text = ""
                    self.studentId.text = ""
                    self.entryYearEd.text = ""
                    
                    self.showAlertDialog(title: "Success!", message: "Info has been submitted", buttonTitle: "Ok")
                }
            }else{
                DispatchQueue.main.async {
                self.showAlertDialog(title: "Fauiler!", message: "Error Occurred: Info hasn't been submitted", buttonTitle: "Ok")
                print("Not Success")
                }
            }
        }

    }
    
    func showAlertDialog(title: String, message: String, buttonTitle: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            NSLog("OK Pressed")
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            alertController.dismiss(animated: false, completion: nil)
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
}
extension AddNewStudentViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.addNewStudentViewModel.numberOfComponentsInPickerView()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.addNewStudentViewModel.numberOfRowsInComponent()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.addNewStudentViewModel.titleForRow(row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row == 0)
        {
             self.searchStatus = "true"
        }
        else if(row == 1)
        {
            self.searchStatus = "false"

        }
//        self.searchStatus = addNewStudentViewModel.titleForRow(row: row)
    }
}
