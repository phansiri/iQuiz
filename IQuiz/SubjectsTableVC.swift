//
//  SubjectsTableViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/2/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit
import Alamofire

class SubjectTableVC: UITableViewController {
    
    var subjects = [Subject]()
    var temp = [Subject]()
    var quizState = QuizState()
    
    var saveModel: SaveModel!
    
    var testInput = ""
    
    
    private var records = SubjectTableVC.getData()
    
    private static func getData() -> [Subject] {
        let data = UserDefaults.standard.array(forKey: "subs")
        if data == nil {
            return Array()
        } else {
            return data as! [Subject]
        }
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        downloadData {
            self.updateData()
        }
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.downloadData {
                self.updateData()
            }
            NSLog("temp \(self.subjects)")
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //subjects.removeAll()
        
        //saveModel = SaveModel()
        //downloadData {
          //  self.updateData()
        //}
        downloadData {
            self.updateData()
        }
        
        self.refreshControl?.addTarget(self, action: #selector(SubjectTableVC.handleRefresh(_:)), for: UIControlEvents.ValueChanged)

    }
    
        /*
        let math = Subject()
        let science = Subject()
        let hero = Subject()
        let mathQuestionOne = Question()
        let scienceQuestion = Question()
        //let heroQuestion = Question()
        let heroQuestionTwo = Question()
        let heroQuestionThree = Question()
        let heroQuestionFour = Question()
        
        math.title = "Mathematics"
        math.desc = "Its Math!"
        math.imageFile = "math icon"
        mathQuestionOne.text = "What is 1 + 1?"
        mathQuestionOne.answer = "2"
        mathQuestionOne.answers = [
            "42",
            "2",
            ".9",
            "I don't know"
        ]
        math.question.append(mathQuestionOne)
        
        science.title = "Science"
        science.desc = "Because Science!"
        science.imageFile = "science icon"
        scienceQuestion.text = "What is O element?"
        scienceQuestion.answer = "4"
        scienceQuestion.answers = [
            "Iron",
            "Nuclear",
            "I don't know",
            "Oxygen"]
        science.question.append(scienceQuestion)
        
        hero.title = "Marvel Super Heroes"
        hero.desc = "Pow!"
        hero.imageFile = "hero icon"
        
        heroQuestionTwo.text = "Who is Iron Man?"
        heroQuestionTwo.answer = "1"
        heroQuestionTwo.answers = [
            "Tony Stark",
            "Obadiah Stane",
            "A rock hit by Megadeth",
            "Nobody knows"
        ]
        hero.question.append(heroQuestionTwo)
        
        heroQuestionThree.text = "Who founded the X-Men?"
        heroQuestionThree.answer = "2"
        heroQuestionThree.answers = [
            "Tony Stark",
            "Professor X",
            "The X-Institute",
            "Erik Lensherr"
        ]
        hero.question.append(heroQuestionThree)
        
        heroQuestionFour.text = "How did Spider-Man get his powers?"
        heroQuestionFour.answer = "1"
        heroQuestionFour.answers = [
            "He was bitten by a radioactive spider",
            "He ate a radioactive spider",
            "He is a radioactive spider",
            "He looked at a radioactive spider"
        ]
        hero.question.append(heroQuestionFour)
        
        subjects.append(math)
        subjects.append(science)
        subjects.append(hero)
        */
        // Part 3 - json
        
    //}
    
    func downloadData(completion: @escaping DownloadComplete) {
        Alamofire.request(BASE_URL).responseJSON { response in
            let resultJSON = response.result
            //NSLog("Inside Alamofire")
            
            if let result = resultJSON.value as? [Dictionary<String, Any>] {
                //NSLog("Retrieved JSON")
                for index in 0...result.count - 1 {
                    let oneSubject = Subject()
                    let question = Question()
                    
                    let obj = result[index]
                    //NSLog("Performing calculations on object: \(index)")
                    // Subject portion
                    let title = obj["title"] as? String
                    let desc = obj["desc"] as? String
                    self.testInput = title!
                    oneSubject.title = title?.capitalized
                    //NSLog("oneSubject title saved with: \(title)")
                    oneSubject.desc = desc?.capitalized
                    //NSLog("oneSubject desc saved with: \(desc)")
                    
                    
                    if oneSubject.title.contains("Math") {
                        oneSubject.imageFile = "math icon"
                        //NSLog("oneSubject imageFile saved with: \(oneSubject.imageFile)")
                    } else if oneSubject.title.contains("Science") {
                        oneSubject.imageFile = "science icon"
                        //NSLog("oneSubject imageFile saved with: \(oneSubject.imageFile)")
                    } else if oneSubject.title.contains("Hero") {
                        oneSubject.imageFile = "hero icon"
                        //NSLog("oneSubject imageFile saved with: \(oneSubject.imageFile)")
                    }
                    
                    // Question portion
                    let questionObj = obj["questions"] as! [Dictionary<String, Any>]
                    for questionIndex in 0...questionObj.count - 1 {
                        let firstQuestion = questionObj[questionIndex]
                        let text = firstQuestion["text"] as! String
                        let answer = firstQuestion["answer"] as! String
                        let answerObj = firstQuestion["answers"] as! [String]
                        question.text = text.capitalized
                        //NSLog("Question text saved with: \(text)")
                        question.answer = answer.capitalized
                        //NSLog("Question answer saved with: \(answer)")
                        question.answers = answerObj
                        //NSLog("Question answers saved with: \(answer)")
                        oneSubject.question.append(question)
                        //NSLog("oneSubject questions saved")
                    }
                    self.temp.append(oneSubject)
                }
            }
            completion()
        }
    }
    
    func updateData() {
        for index in 0...temp.count - 1 {
            subjects.append(temp[index])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("Rows Subjects: \(subjects.count)")
        return subjects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SubjectCellTableViewCell
        
        let subject = subjects[indexPath.row]
        //NSLog("subject: \(subject)")
        
        cell.titleLabel.text = subject.title
        cell.descLabel.text = subject.desc
        cell.imageLabel.image = UIImage(named: (subject.imageFile))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subject = subjects[indexPath.row]
        performSegue(withIdentifier: "QuestionVC", sender: subject)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionVC {
            if let subject = sender as? Subject {
                
                // NSLog("SubjectTableVC - subject: \(subject)")
                
                // subject and questions
                destination.questionModel = subject
                
                // quiz state initated and sent over
                quizState.questionCounter = 0
                quizState.questionAnsweredCorrectly = 0
                quizState.maxQuestion = subject.question.count
                quizState.answerPressed = -1
                quizState.isCorrect = false
                
                // NSLog("SubjectTableVC - quizState: \(quizState)")
                
                
                destination.quizState = quizState
                
            }
        }
    }
    
    
}
