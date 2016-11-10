//
//  QuizTimeViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/3/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var answerALabel: UILabel!
    @IBOutlet weak var answerBLabel: UILabel!
    @IBOutlet weak var answerCLabel: UILabel!
    @IBOutlet weak var answerDLabel: UILabel!
    
    var questionModel: Subject = Subject()
    var quizState: QuizState = QuizState()
    
    
    @IBAction func answerButton(_ sender: UIButton) {
        quizState.answerPressed = sender.tag
    }
    @IBAction func backHomeButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        if let home = self.storyboard?.instantiateViewController(withIdentifier: "Initial") as? UINavigationController {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(home, animated: true, completion: nil)
        }
    }
    
    @IBAction func nextToAnswerButton(_ sender: UIBarButtonItem) {
        
        // if pressed on a button
        if quizState.answerPressed != -1 {
            
            // NSLog("Question Answer: \(Int(questionModel.question[quizState.questionCounter].answer)! - 1)")
            // NSLog("Button Pressed: \(quizState.answerPressed))")
            
            // if answer is correct
            if (Int(questionModel.question[quizState.questionCounter].answer)! - 1) == quizState.answerPressed {
                quizState.questionAnsweredCorrectly = quizState.questionAnsweredCorrectly + 1
                quizState.isCorrect = true
                performSegue(withIdentifier: "AnswerVC", sender: questionModel)
            } else { // if answer is not correct
                quizState.questionAnsweredCorrectly = quizState.questionAnsweredCorrectly + 0
                quizState.isCorrect = false
                performSegue(withIdentifier: "AnswerVC", sender: questionModel)
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = questionModel.title
        
        textLabel.text = questionModel.question[quizState.questionCounter].text
        
        /*
         NSLog("QuestionVC -viewDidLoad- counter: \(quizState.questionCounter)")
         NSLog("QuestionVC -viewDidLoad- correctly answered: \(quizState.questionAnsweredCorrectly)")
         NSLog("QuestionVC -viewDidLoad- maxQ: \(quizState.maxQuestion)")
         NSLog("QuestionVC -viewDidLoad- isCorrect: \(quizState.isCorrect)")
         NSLog("QuestionVC -viewDidLoad- answerPressed: \(quizState.answerPressed)")
         */
        
        
        let numberOfAnswers = Int((questionModel.question[quizState.questionCounter].answers.count)) - 1
        let question = questionModel.question[quizState.questionCounter]
        for index in 0...numberOfAnswers {
            if index == 0 {
                answerALabel.text = question.answers[index]
            }
            if index == 1 {
                answerBLabel.text = question.answers[index]
            }
            if index == 2 {
                answerCLabel.text = question.answers[index]
            }
            if index == 3 {
                answerDLabel.text = question.answers[index]
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AnswerVC {
            if let subject = sender as? Subject {
                destination.questionModel = subject
                destination.quizState = quizState
            }
        }
    }
    
    
    
}

