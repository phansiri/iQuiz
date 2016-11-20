//
//  QuizTimeViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/3/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit
import CoreData

class QuestionVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var answerALabel: UILabel!
    @IBOutlet weak var answerBLabel: UILabel!
    @IBOutlet weak var answerCLabel: UILabel!
    @IBOutlet weak var answerDLabel: UILabel!
    
    var questionModel: SubjectObj = SubjectObj()
    var subjectCoreData: Subject?
    lazy var questions = [Question]()
    lazy var answers = [Answers]()
    var quizState: QuizState = QuizState()
    
    
    @IBAction func answerButton(_ sender: UIButton) {
        quizState.answerPressed = sender.tag
        if sender.tag == 0 {
            answerALabel.backgroundColor = UIColor.brown
            answerBLabel.backgroundColor = UIColor.white
            answerCLabel.backgroundColor = UIColor.white
            answerDLabel.backgroundColor = UIColor.white
        } else if sender.tag == 1 {
            answerALabel.backgroundColor = UIColor.white
            answerBLabel.backgroundColor = UIColor.brown
            answerCLabel.backgroundColor = UIColor.white
            answerDLabel.backgroundColor = UIColor.white
        } else if sender.tag == 2 {
            answerALabel.backgroundColor = UIColor.white
            answerBLabel.backgroundColor = UIColor.white
            answerCLabel.backgroundColor = UIColor.brown
            answerDLabel.backgroundColor = UIColor.white
        } else if sender.tag == 3 {
            answerALabel.backgroundColor = UIColor.white
            answerBLabel.backgroundColor = UIColor.white
            answerCLabel.backgroundColor = UIColor.white
            answerDLabel.backgroundColor = UIColor.brown
        }
    }
    
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        // NSLog("Swipe Right: \(sender)")
        dismiss(animated: true, completion: nil)
        if let home = self.storyboard?.instantiateViewController(withIdentifier: "Initial") as? UINavigationController {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(home, animated: true, completion: nil)
        }
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        // NSLog("Swipe Left: \(sender)")
        
        // if pressed on a button
        if quizState.answerPressed != -1 {
        
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
 
    @IBAction func backHomeButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        if let home = self.storyboard?.instantiateViewController(withIdentifier: "Initial") as? UINavigationController {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(home, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func nextToAnswerButton(_ sender: UIBarButtonItem) {
        actionButton()
    }
    
    //func actionButton(_ sender: UIBarButtonItem) {
    func actionButton() {
        // if pressed on a button
        if quizState.answerPressed != -1 {
            
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
        
        loadSubject()
        
        
        questionLabel.text = subjectCoreData?.title
        textLabel.text = questions[quizState.questionCounter].text
        
        answerALabel.text = answers[0].answer
        answerBLabel.text = answers[1].answer
        answerCLabel.text = answers[2].answer
        answerDLabel.text = answers[3].answer
        
//
//        let numberOfAnswers = Int((questionModel.question[quizState.questionCounter].answers.count)) - 1
//        let question = questionModel.question[quizState.questionCounter]
//        for index in 0...numberOfAnswers {
//            if index == 0 {
//                answerALabel.text = question.answers[index]
//            }
//            if index == 1 {
//                answerBLabel.text = question.answers[index]
//            }
//            if index == 2 {
//                answerCLabel.text = question.answers[index]
//            }
//            if index == 3 {
//                answerDLabel.text = question.answers[index]
//            }
//        }
    }
    
    func loadSubject() {
//        NSLog("QuestionVC : \(subjectCoreData)")
//        let question = Question(context: context)
        questions = getQuestion(subject: subjectCoreData!)
        answers = getAnswers(question: questions[quizState.questionCounter])
//        NSLog("Questions Counter: \(questions.count)")
        quizState.maxQuestion = questions.count
//        NSLog("Quiz state: \(quizState.questionCounter)")
        
        
//        getAnswers(question: questions[quizState.questionCounter])
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AnswerVC {
            if let subject = sender as? SubjectObj {
                destination.questionModel = subject
                destination.quizState = quizState
            }
        }
    }
    
}

