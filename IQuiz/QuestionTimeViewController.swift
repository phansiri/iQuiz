//
//  QuizTimeViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/3/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class QuestionTimeViewController: UIViewController {
    
    //var question = [Dictionary<String,[Dictionary<String,String>]>()]
    //var question = [Dictionary<String,String>()]
    var question = [ModelQuesiton()]
    var questionCounter = 0
    var questionAnswered = 0
    var upperValueForRandomNumber: Int = 0
    var randomQuestion: Int = 0
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBAction func backToSubjectViewButton(_ sender: Any) {
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
    }
    @IBOutlet weak var subjectLabel: UILabel!

    @IBAction func backHome(_ sender: Any) {
        self.performSegue(withIdentifier: "BackHome", sender: self)
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
        
        NSLog("The Question is: \(question[questionCounter].question)")
        
        questionLabel.text = question[questionCounter].question
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("The value of subjectLabel is: \(subjectLabel)")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            questionTwo.question = "Can Superman is weak to?"
            questionTwo.answer = "Kryptonite"
            let questionThree = ModelQuesiton()
            questionThree.subject = "hero"
            questionThree.question = "Does Superman beat Batman?"
            questionThree.answer = "It depends..."
            question.append(questionOne)
            question.append(questionTwo)
            question.append(questionThree)
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
