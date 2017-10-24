//
//  AddQuestionViewController.swift
//  MUM-CareetTest-AdminPortal
//
//  Created by Laith Mihyar on 10/18/17.
//  Copyright © 2017 Laith Miehiar. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController, SSRadioButtonControllerDelegate{
    
    var subCategory: SubCategory!
    @IBOutlet weak var answer1: SSRadioButton!
    @IBOutlet weak var answer2: SSRadioButton!
    @IBOutlet weak var answer3: SSRadioButton!
    @IBOutlet weak var answer4: SSRadioButton!
    @IBOutlet weak var answer5: SSRadioButton!
    
    @IBOutlet weak var categoryMap: UILabel!
    @IBOutlet weak var questionText: UITextField!
    
    @IBOutlet weak var answerText1: UITextField!
    @IBOutlet weak var answerText2: UITextField!
    @IBOutlet weak var answerText3: UITextField!
    @IBOutlet weak var answerText4: UITextField!
    @IBOutlet weak var answerText5: UITextField!
    
    
    var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        
        DispatchQueue.main.async {
//            self.categoryMap.text = self.subCategory.name
        }
        
        
        radioButtonController = SSRadioButtonsController(buttons: answer1, answer2, answer3,answer4,answer5)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        print(" \(String(describing: selectedButton?.tag))" )
    }
    
    @IBAction func submitQuestion(_ sender: Any) {
        //at least should be 4 answer and one question for the question
        checkAnswerInput()
        
        
        
        
    }
    
    func checkAnswerInput(){
        
        guard questionText.text != nil else{
            questionText.attributedPlaceholder = NSAttributedString(string: "Please Type Question ",
                                                                    attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            return
        }
        
        guard answerText1.text != nil else{
            answerText1.attributedPlaceholder = NSAttributedString(string: "Type Answer 1",
                                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            return
        }
        guard answerText2.text != nil else{
            answerText1.attributedPlaceholder = NSAttributedString(string: "Type Answer 3",
                                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            return
        }
        guard answerText3.text != nil else{
            answerText1.attributedPlaceholder = NSAttributedString(string: "Type Answer 3",
                                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            return
        }
        guard answerText4.text != nil else{
            answerText1.attributedPlaceholder = NSAttributedString(string: "Type Answer 4",
                                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            return
        }
    }
    
}
