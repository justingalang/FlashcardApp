//
//  CreationViewController.swift
//  FlashcardWeek5
//
//  Created by Justin Galang on 3/9/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardController: ViewController!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var initialQuestion : String?
    var initialAnswer : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer	
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        
        //input validation
        if (questionText == nil || answerText == nil ||
            questionText!.isEmpty || answerText!.isEmpty) {
            //create alert
            let alert = UIAlertController(title: "Missing Text", message: "Please fill in both fields" , preferredStyle: .alert)
            //add dismiss button
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            //Show
            present(alert, animated: true)
        } else {
            //check to see if existing
            var isExisting = false
            if initialQuestion != nil {
                isExisting = true
            }
            
            flashcardController.updateFlashcard(question: questionText!, answer: answerText!, isExisting: isExisting)
            dismiss(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
