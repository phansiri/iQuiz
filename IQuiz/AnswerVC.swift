//
//  AnswerViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/9/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit
import CoreData

class AnswerVC: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var questionModel: SubjectObj = SubjectObj()
    var subjectCoreData: Subject?
    lazy var questions = [Question]()
    lazy var answers = [Answers]()
    lazy var correctAnswer = ""
    var quizState: QuizState = QuizState()
    
    @IBAction func backHomeButton(_ sender: UIBarButtonItem) {
        actionHome()
//        dismiss(animated: true, completion: nil)
//        if let home = self.storyboard?.instantiateViewController(withIdentifier: "Initial") as? UINavigationController {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController!.present(home, animated: true, completion: nil)
//        }
    }
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        actionButton()
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        actionHome()
//        dismiss(animated: true, completion: nil)
//        if let home = self.storyboard?.instantiateViewController(withIdentifier: "Initial") as? UINavigationController {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController!.present(home, animated: true, completion: nil)
//        }
    }
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        actionButton()
    }
    
    func actionHome() {
        dismiss(animated: true, completion: nil)
        if let home = self.storyboard?.instantiateViewController(withIdentifier: "Initial") as? UINavigationController {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(home, animated: true, completion: nil)
        }
    }
    
    func actionButton() {
        quizState.questionCounter = quizState.questionCounter + 1
        
        if quizState.questionCounter != quizState.maxQuestion {
            
            quizState.isCorrect = false
            quizState.answerPressed = -1
            
            // NSLog("AnswerVC to QuestionVC -counter not equal to max: \(quizState.questionCounter)")
            
            performSegue(withIdentifier: "QuestionVC", sender: subjectCoreData)
            
        } else {
            
            // NSLog("AnswerVC to QuestionVC -counter equal to max: \(quizState.questionCounter)")
            
            performSegue(withIdentifier: "FinishVC", sender: quizState)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSubject()
        questionLabel.text = questions[quizState.questionCounter].text
        
//        questionLabel.text = questionModel.question[quizState.questionCounter].text
        
        if quizState.isCorrect == true {
            resultLabel.text = "Great Job!"
        } else {
            resultLabel.text = "You got it wrong! The answer is \(quizState.correctAnswer!)"
//            let number = Int(questionModel.question[quizState.questionCounter].answer)! - 1
//            let correctAnswer = questionModel.question[quizState.questionCounter]
//            // NSLog("Question Answer: \(number)")
//            // NSLog("Question Counter: \(quizState.questionCounter!)")
//            // NSLog("Question Correct: \(correctAnswer.answers[number])")
//            resultLabel.text = "You got it wrong! The answer is \(correctAnswer.answers[number])"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadSubject() {
        questions = getQuestion(subject: subjectCoreData!)
        answers = getAnswers(question: questions[quizState.questionCounter])
        quizState.maxQuestion = questions.count
    }
    
    // returns an array of questions
    func getQuestion(subject: Subject) -> [Question] {
        let questionRequest: NSFetchRequest<Question> = Question.fetchRequest()
        questionRequest.predicate = NSPredicate(format: "toSubject = %@", subject)
        
        do {
            let questions = try context.fetch(questionRequest)
            return questions
        } catch {
            fatalError("Error in getQuestion")
        }
    }
    
    // returns an array of answers
    func getAnswers(question: Question) -> [Answers] {
        let answersRequest: NSFetchRequest<Answers> = Answers.fetchRequest()
        answersRequest.predicate = NSPredicate(format: "toQuestion = %@", question)
        
        do {
            let answers = try context.fetch(answersRequest)
            return answers
        } catch {
            fatalError("Error in getQuestion")
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionVC {
            if let subject = sender as? Subject {
//                destination.questionModel = subject
                destination.subjectCoreData = subject
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
