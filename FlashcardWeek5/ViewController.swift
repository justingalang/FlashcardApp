//
//  ViewController.swift
//  FlashcardWeek5
//
//  Created by Justin Galang on 3/9/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Flashcard {
        var question : String
        var answer : String
    }
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
       
    override func viewDidLoad() {
        super.viewDidLoad()
        readSavedFlashcards()
        
        //create first card if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "There are no cards", answer: "Hit the + to add a card", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButton()
        }
        
        //card style
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15
        card.layer.shadowOpacity = 0.35
        
        //label style
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
            creationController.flashcardController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            
        }
        
    }
    
    //Flips card
    @IBAction func didTapOnCard(_ sender: Any) {
        if (frontLabel.isHidden == true){
            frontLabel.isHidden = false
        } else {
            frontLabel.isHidden = true
        }
    }
    
    //changes labels on card
    func updateFlashcard(question: String, answer: String, isExisting: Bool)  {
        //utilizing struct
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        if isExisting {
            flashcards[currentIndex] = flashcard
        } else {
            //adding to flashcard array
            flashcards.append(flashcard)
            print("added new flashcard")
            print("We now have \(flashcards.count) cards")
            
            //update currentIndex
            currentIndex = flashcards.count - 1
            //Log
            print("Current Index: \(currentIndex)")
        }
        
        //Update
        updateNextPrevButton()
        updateLabels()
        
        //save
        saveAllFlashCardsToDisk()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex += 1
        updateLabels()
        updateNextPrevButton()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex -= 1
        updateLabels()
        updateNextPrevButton()
    }
    
    func updateLabels() {
        //get current card
        let currentFlashcard = flashcards[currentIndex]
        
        //update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    //disables next and previous
    func updateNextPrevButton() {
        if (currentIndex == flashcards.count - 1) {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        //disable prev button if at beginning
        if (currentIndex == 0) {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func saveAllFlashCardsToDisk(){
        
        //dictionary for cards
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    
}

