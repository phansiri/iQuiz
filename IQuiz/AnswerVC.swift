//
//  AnswerViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/9/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class AnswerVC: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var questionModel: Subject = Subject()
    var quizState: QuizState = QuizState()
    
    @IBAction func backHomeButton(_ sender: UIBarButtonItem) {
        //navigationController?.popViewController(animated: true)
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        if let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "Initial") as? UINavigationController {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(vc3, animated: true, completion: nil)
        }
    }
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        
        quizState.questionCounter = quizState.questionCounter + 1
        
        print(quizState.questionCounter)
        print(quizState.maxQuestion)
        
        if quizState.questionCounter != quizState.maxQuestion {
            
            quizState.isCorrect = false
            quizState.answerPressed = -1
            
            NSLog("AnswerVC to QuestionVC -counter not equal to max: \(quizState.questionCounter)")
            
            performSegue(withIdentifier: "QuestionVC", sender: questionModel)
            
        } else {
            
            NSLog("AnswerVC to QuestionVC -counter equal to max: \(quizState.questionCounter)")
            
            performSegue(withIdentifier: "FinishVC", sender: quizState)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = questionModel.question[quizState.questionCounter].text
        
        if quizState.isCorrect == true {
            resultLabel.text = "Great Job!"
        } else {
            resultLabel.text = "You got it wrong! The answer is \(questionModel.question[quizState.questionCounter].answer)"
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionVC {
            if let subject = sender as? Subject {
                destination.questionModel = subject
                destination.quizState = quizState
            }
        }
        if let destination = segue.destination as? FinishVC {
            if let quiz = sender as? QuizState {
                //destination.questionModel = subject
                destination.quizState = quiz
            }
        }
    }
    
    
}