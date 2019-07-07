//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let questions = QuestionBank()
    
    var userAnswer : Bool = false
    var curr : Int = -1
    var score : Int  =  0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            userAnswer = true
        }else{
            userAnswer = false
        }
        checkAnswer()
    }
    
    
    func updateUI() {
        nextQuestion()
        scoreLabel.text = "Score: \(score) "
        progressLabel.text = "\((curr)%questions.list.count + 1)/\(questions.list.count)"
        progressBar.frame.size.width = (view.frame.size.width/CGFloat(questions.list.count)) * CGFloat(curr + 1)
    }
    

    func nextQuestion() {
        curr += 1
        if curr <= 12{
            questionLabel.text = questions.list[curr].questionText
        }else{
            let alert = UIAlertController(title: "Quiz compleate", message: "do you want to start again", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Restart",  style: .default, handler:{(UIAlertAction) in self.startOver()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        if userAnswer == questions.list[curr].answer{
            ProgressHUD.showSuccess("Got it!")
            score += 1000
        }else{
            ProgressHUD.showError("No, You Dumb Dumb!")
        }
        
    }
    
    
    func startOver() {
        curr = -1
        score = 0
        updateUI()
    }
    

    
}
