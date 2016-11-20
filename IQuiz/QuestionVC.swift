//
//  QuizTimeViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/3/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit
import CoreData

class QuestionVC: UIViewController, UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var answerALabel: UILabel!
    @IBOutlet weak var answerBLabel: UILabel!
    @IBOutlet weak var answerCLabel: UILabel!
    @IBOutlet weak var answerDLabel: UILabel!
    @IBOutlet weak var answerPickerView: UIPickerView!
    
//    var questionModel: SubjectObj = SubjectObj()
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
        actionHome()
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        actionButton()
    }
 
    @IBAction func backHomeButton(_ sender: UIBarButtonItem) {
        actionHome()
    }
    
    
    @IBAction func nextToAnswerButton(_ sender: UIBarButtonItem) {
        actionButton()
    }
    
    func actionHome() {
        dismiss(animated: true, completion: nil)
        if let home = self.storyboard?.instantiateViewController(withIdentifier: "Initial") as? UINavigationController {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(home, animated: true, completion: nil)
        }
    }
    
    //func actionButton(_ sender: UIBarButtonItem) {
    func actionButton() {

        // check the selected item with correct answer
        let selectedPickerAnswer = answers[answerPickerView.selectedRow(inComponent: 0)].answer
        let questionAnswer = questions[quizState.questionCounter].answer
        
        if selectedPickerAnswer == questionAnswer {
            NSLog("They both match")
            quizState.isCorrect = true
            quizState.questionAnsweredCorrectly = quizState.questionAnsweredCorrectly + 1
        } else {
            NSLog("They don't match")
            quizState.isCorrect = false
            quizState.questionAnsweredCorrectly = quizState.questionAnsweredCorrectly + 0
            quizState.correctAnswer = questionAnswer
        }
        performSegue(withIdentifier: "AnswerVC", sender: subjectCoreData)
        
        // if pressed on a button
        /*
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
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSubject()
        
        questionLabel.text = subjectCoreData?.title
        textLabel.text = questions[quizState.questionCounter].text
        
        answerPickerView.delegate = self
        answerPickerView.dataSource = self
    }
    
    // Picker boilerplate codes
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let singleAnswer = answers[row]
        return singleAnswer.answer
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answers.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // update to come
    }
    
    func loadSubject() {
        questions = getQuestion(subject: subjectCoreData!)
        answers = getAnswers(question: questions[quizState.questionCounter])
        quizState.maxQuestion = questions.count
    }

    // returns an array of questions
    func getQuestion(subject: Subject) -> [Question] {
        if questions.isEmpty {
            let questionRequest: NSFetchRequest<Question> = Question.fetchRequest()
            questionRequest.predicate = NSPredicate(format: "toSubject = %@", subject)
            
            do {
                let questions = try context.fetch(questionRequest)
                return questions
            } catch {
                fatalError("Error in getQuestion")
            }
        }
        return questions
    }
    
    // returns an array of answers
    func getAnswers(question: Question) -> [Answers] {
        if answers.isEmpty {
            let answersRequest: NSFetchRequest<Answers> = Answers.fetchRequest()
            answersRequest.predicate = NSPredicate(format: "toQuestion = %@", question)
            
            do {
                let answers = try context.fetch(answersRequest)
                return answers
            } catch {
                fatalError("Error in getQuestion")
            }
        }
        return answers
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AnswerVC {
            if let subject = sender as? Subject {
                destination.subjectCoreData = subject
                destination.quizState = quizState
            }
        }
    }
    
}

