//
//  QuizTimeViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/3/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class QuestionTimeViewController: UIViewController {
    
    private var subjectsTableViewController: SubjectsTableViewController!
    private var uiNavigationController: UINavigationController!
    
    private func builderOne() {
        if subjectsTableViewController == nil {
            subjectsTableViewController = (storyboard?.instantiateViewController(withIdentifier: "Subjects") as! SubjectsTableViewController)
        }
        if uiNavigationController == nil {
            uiNavigationController = (storyboard?.instantiateViewController(withIdentifier: "NavHome") as! UINavigationController)
        }
    }
    
    //var question = [Dictionary<String,[Dictionary<String,String>]>()]
    //var question = [Dictionary<String,String>()]
    var question = [ModelQuesiton()]
    var questionCounter = 0
    var questionAnswered = 0
    var upperValueForRandomNumber: Int = 0
    var randomQuestion: Int = 0
    var answerRandomLocation = [Dictionary<Bool,String>()] // Insert a bool to see if it is the correct answer
    //let boarderColor = UIColor.blue.cgColor
    var isCorrect = false
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerALabel: UIButton!
    @IBOutlet weak var answerBLabel: UIButton!
    @IBOutlet weak var answerCLabel: UIButton!
    @IBOutlet weak var answerDLabel: UIButton!
    
    @IBAction func nextButton(_ sender: Any) {
        
    }
    
    @IBOutlet weak var subjectLabel: UILabel!

    
    @IBAction func answerAButton(_ sender: UIButton) {
        if questionCounter == 0 {
            if question[questionCounter].answer == question[questionCounter].answer {
                questionAnswered += 1
                isCorrect = true
            }
        }
        answerALabel.backgroundColor = UIColor.blue
        answerBLabel.backgroundColor = UIColor.white
        answerCLabel.backgroundColor = UIColor.white
        answerDLabel.backgroundColor = UIColor.white

    }
    
    @IBAction func answerBButton(_ sender: UIButton) {
        answerALabel.backgroundColor = UIColor.white
        answerBLabel.backgroundColor = UIColor.blue
        answerCLabel.backgroundColor = UIColor.white
        answerDLabel.backgroundColor = UIColor.white
        isCorrect = false
    }
    
    @IBAction func answerCButton(_ sender: UIButton) {
        answerALabel.backgroundColor = UIColor.white
        answerBLabel.backgroundColor = UIColor.white
        answerCLabel.backgroundColor = UIColor.blue
        answerDLabel.backgroundColor = UIColor.white
        isCorrect = false

    }
    
    @IBAction func answerDButton(_ sender: UIButton) {
        answerALabel.backgroundColor = UIColor.white
        answerBLabel.backgroundColor = UIColor.white
        answerCLabel.backgroundColor = UIColor.white
        answerDLabel.backgroundColor = UIColor.blue
        isCorrect = false
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackHome" {
            let viewController = segue.destination as! SubjectsTableViewController
        }
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = subjects[subjectCounter]

        loadData(data: data)
        
        loadQuestions(subject: data["subject"]!)
        
        upperValueForRandomNumber = question.count
        //randomQuestion = Int(arc4random_uniform(UInt32(upperValueForRandomNumber) + 1))
        
        //NSLog("Random Question: \(randomQuestion)")
        
        questionNumberLabel.text = "Question: \(questionCounter + 1)"
        
        //NSLog("The Question is: \(question[questionCounter].question)")
        
        questionLabel.text = question[questionCounter].question
        answerALabel.setTitle(question[questionCounter].answer, for: .normal)
        answerBLabel.setTitle("It must be A", for: .normal)
        answerCLabel.setTitle("Maybe all of the above", for: .normal)
        answerDLabel.setTitle("Must not be anything of them", for: .normal)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData(data: [String:String]) {
        let data = subjects[subjectCounter]
        subjectLabel.text = data["subject"]
    }
    
    func loadQuestions(subject: String) {
        if subject == "Mathematics" {
            question.removeAll()
            let questionOne = ModelQuesiton()
            questionOne.subject = "math"
            questionOne.question = "What is 1 + 1"
            questionOne.answer = "2"
            let questionTwo = ModelQuesiton()
            questionTwo.subject = "math"
            questionTwo.question = "What is 15 + 1"
            questionTwo.answer = "16"
            let questionThree = ModelQuesiton()
            questionThree.subject = "math"
            questionThree.question = "How old am I?"
            questionThree.answer = "Younger than you"
            question.append(questionOne)
            question.append(questionTwo)
            question.append(questionThree)
        } else if subject == "Science" {
            question.removeAll()
            let questionOne = ModelQuesiton()
            questionOne.subject = "science"
            questionOne.question = "What is the chemical symbol of oxygen"
            questionOne.answer = "O"
            let questionTwo = ModelQuesiton()
            questionTwo.subject = "science"
            questionTwo.question = "Another name for a tidal wave"
            questionTwo.answer = "Tsunami"
            let questionThree = ModelQuesiton()
            questionThree.subject = "science"
            questionThree.question = "Whats my lucky number?"
            questionThree.answer = "7"
            question.append(questionOne)
            question.append(questionTwo)
            question.append(questionThree)
        } else if subject == "Marvel Super Heroes" {
            question.removeAll()
            let questionOne = ModelQuesiton()
            questionOne.subject = "hero"
            questionOne.question = "Who is Clark Kent"
            questionOne.answer = "Superman"
            let questionTwo = ModelQuesiton()
            questionTwo.subject = "hero"
            questionTwo.question = "Who can weild Thor's hammer?"
            questionTwo.answer = "Thor"
            let questionThree = ModelQuesiton()
            questionThree.subject = "hero"
            questionThree.question = "Does Superman beat Batman?"
            questionThree.answer = "It depends..."
            question.append(questionOne)
            question.append(questionTwo)
            question.append(questionThree)
        }
        
    }
    
    private func switchViewController(from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMove(toParentViewController: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, at: 0)
            to!.didMove(toParentViewController: self)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
